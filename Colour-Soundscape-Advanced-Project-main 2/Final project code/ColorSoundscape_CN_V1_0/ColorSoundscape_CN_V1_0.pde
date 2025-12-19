import gab.opencv.*;                                                // OpenCV library
import processing.video.*;                                          // Video library
import java.awt.Rectangle;                                          // Library file
import processing.sound.*;                                          // Sound library

// Font display -----------------------------------------------------
PFont chineseFont;                                                  // Chinese font object

// Camera OpenCV ----------------------------------------------------
OpenCV opencv;                                                      // OpenCV object
Capture video;                                                      // Camera feed

// Music control ----------------------------------------------------
SoundFile[] tracks;                                                 // Store all music files
boolean[] isPlaying;                                                // Track whether each music is playing
float[] targetVolumes;                                              // Target volume for each track
float[] currentVolumes;                                             // Current volume for each track

// System parameters ------------------------------------------------
int regionSize = 100;                                               // Set region size
color[] targetColors = {                                            // Define target color ranges (RGB format) and names
  color(216, 124, 69),
  color(208, 186, 120),
  color(140,16,28),
  color(85, 28, 20),
  color(64, 87, 40)
};
String[] colorNames = {"midyellow","lightyellow","red","brown","green"};
// RGB tolerance range for each color
int[] colorTolerances = {30, 15, 20, 25, 20};                       // Tolerance range for each color

float volumeChanges = 0.005;                                        // Volume change speed
long[] recordRunTimes = {0, 0, 0, 0, 0};                            // Record run times
int setKeepRunTime = 1 * 10 * 1000;                                 // Set keep-alive time for music (ms)

void setup() {
  pixelDensity(1);                                                  // Set pixel density explicitly
  size(640, 480);                                                   // Set window size

  // Display font --------------------------
  chineseFont = createFont("SimHei", 16);                           // Set font and size
  textFont(chineseFont);                                            // Apply font

  // Music initialization -------------------
  tracks = new SoundFile[5];                                        // Initialize music and volume states
  isPlaying = new boolean[5];                                       // State array
  targetVolumes = new float[5];
  currentVolumes = new float[5];
  // Load music files (ensure 1.wav, 2.wav, ..., 5.wav in data folder)
  for (int i = 0; i < tracks.length; i++) {                         // for loop settings
    tracks[i] = new SoundFile(this, (i + 1) + ".wav");              // Load music file
    isPlaying[i] = false;                                           // Initialize state
    targetVolumes[i] = 0.0;                                         // Target volume 0
    currentVolumes[i] = 0.0;                                        // Current volume 0
  }

  // Initialize camera -----------------------
  String[] cameras = Capture.list();                                // List all available cameras
  if (cameras.length == 0) {
    println("No camera detected!");
    exit();
  } else {
    for (int i = 0; i < cameras.length; i++) {                      // Print camera info
      println("Camera " + i + ": " + cameras[i]);
    }
  }
  video = new Capture(this, width, height, cameras[1]);             // Select camera
  video.start();                                                    // Start camera

  // Initialize OpenCV ------------------------
  opencv = new OpenCV(this, width, height);
}

void draw() {
  // Get frame ---------------------------------
  if (video.available()) {                                          // If frame available
    video.read();                                                   // Read frame
  }

  // Display original image ---------------------
  image(video, 0, 0);                                               // Show video

  // Detect each target color --------------------
  for (int i = 0; i < targetColors.length; i++) {
    detectColor(targetColors[i], colorTolerances[i], colorNames[i]);
  }

  // Update volumes of all tracks (independent)
  for (int i = 0; i < tracks.length; i++) {                         // Handle music threads
    if (isPlaying[i]) {                                             // Check music state
      // Volume control ------------------------
      if (currentVolumes[i] < targetVolumes[i]) {                   // Volume fade-in
        currentVolumes[i] = lerp(currentVolumes[i], targetVolumes[i], volumeChanges);
        tracks[i].amp(currentVolumes[i]);                           // Apply volume
      }
      // If object disappears, check timeout ----
      if(millis() - recordRunTimes[i] >= setKeepRunTime){           // Check time
        tracks[i].stop();                                           // Stop music
        isPlaying[i] = false;                                       // Update state
        targetVolumes[i] = 0.0;                                     // Reset target volume
        currentVolumes[i] = 0.0;                                    // Reset current volume
      }
    }
  }

  // End of draw
}

// Detect color -------------------------------------------------------------------
void detectColor(int targetColor, int tolerance, String colorName) {
  // Get target RGB components ----------------------
  float targetR = red(targetColor);
  float targetG = green(targetColor);
  float targetB = blue(targetColor);

  // Create mask image ------------------------------
  PImage colorMask = createImage(video.width, video.height, RGB);

  for (int y = 0; y < video.height; y++) {
    for (int x = 0; x < video.width; x++) {
      color pixelColor = video.get(x, y);
      float pixelR = red(pixelColor);
      float pixelG = green(pixelColor);
      float pixelB = blue(pixelColor);

      // Calculate color distance --------------------
      float colorDistance = dist(pixelR, pixelG, pixelB, targetR, targetG, targetB);

      // Check if within tolerance -------------------
      if (colorDistance < tolerance) {
        colorMask.set(x, y, color(255));
      } else {
        colorMask.set(x, y, color(0));
      }
    }
  }

  // Process mask image -----------------------------
  opencv.loadImage(colorMask);
  opencv.erode();
  opencv.dilate();

  // Find contours ----------------------------------
  ArrayList<Contour> contours = opencv.findContours();

  // Draw detected regions ---------------------------
  noFill();
  stroke(targetColor);
  strokeWeight(2);

  for (Contour contour : contours) {
    if (contour.area() > regionSize) {                 // Only keep large regions
      Rectangle r = contour.getBoundingBox();

      // Draw bounding box --------------------------
      rect(r.x, r.y, r.width, r.height);

      // Calculate average color ---------------------
      color avgColor = getAverageColor(video, r);

      // Display color name + RGB ---------------------
      fill(targetColor);
      textAlign(CENTER, CENTER);
      String info = colorName + "\nR:" + (int)red(avgColor) +
        " G:" + (int)green(avgColor) +
        " B:" + (int)blue(avgColor);
      text(info, r.x + r.width/2, r.y - 20);
      
      // Music control based on color name -----------
      for (int i = 0; i < colorNames.length; i++) {
        if (colorName != null && colorNames[i].equals(colorName)) {
          recordRunTimes[i] = millis();
          
          // If not playing, start with fade-in ------
          if (isPlaying[i] == false) {
            tracks[i].loop();              // Loop play
            isPlaying[i] = true;
            targetVolumes[i] = 1;          // Set target volume 100%
            currentVolumes[i] = 0.0;       // Start from silence
          }
        }
      }

    }
  }
}

// Get average color in region -----------------------------------------------------
color getAverageColor(PImage img, Rectangle r) {
  float rSum = 0, gSum = 0, bSum = 0;
  int count = 0;
  // Ensure region is within image ---------------
  int xStart = max(0, r.x);
  int yStart = max(0, r.y);
  int xEnd = min(img.width, r.x + r.width);
  int yEnd = min(img.height, r.y + r.height);
  for (int y = yStart; y < yEnd; y++) {
    for (int x = xStart; x < xEnd; x++) {
      color c = img.get(x, y);
      rSum += red(c);
      gSum += green(c);
      bSum += blue(c);
      count++;
    }
  }
  if (count > 0) {
    return color(rSum/count, gSum/count, bSum/count);
  } else {
    return color(0);
  }
}
