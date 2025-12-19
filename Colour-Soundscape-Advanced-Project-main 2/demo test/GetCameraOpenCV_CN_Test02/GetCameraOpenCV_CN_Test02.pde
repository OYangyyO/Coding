import gab.opencv.*;         // Import OpenCV library for Processing
import processing.video.*;   // Import video library
import java.awt.Rectangle;

OpenCV opencv;
Capture video;

PFont chineseFont;           // Font object

// Define target colors (in RGB format) and their names
color[] targetColors = {
  color(85, 28, 20),
  color(208, 186, 120),
  color(116, 150, 98),
  color(216, 124, 69),
  color(140, 16, 28)
};
String[] colorNames = {"brown", "lightyellow", "green", "midyellow", "red"};

// RGB tolerance for each color
int[] colorTolerances = {25, 15, 20, 30, 20};

void setup() {
  pixelDensity(1);
  size(640, 480);
  chineseFont = createFont("SimHei", 16);
  textFont(chineseFont);

  // List all available cameras
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("No camera detected!");
    exit();
  } else {
    for (int i = 0; i < cameras.length; i++) {
      println("Camera " + i + ": " + cameras[i]);
    }
  }
  
  // Initialize camera
  video = new Capture(this, width, height, cameras[1]);
  video.start();

  // Initialize OpenCV
  opencv = new OpenCV(this, width, height);
}

void draw() {
  if (video.available()) {
    video.read();
  }

  // Display the original video frame
  image(video, 0, 0);

  // Detect each target color
  for (int i = 0; i < targetColors.length; i++) {
    detectColor(targetColors[i], colorTolerances[i], colorNames[i]);
  }
}

void detectColor(int targetColor, int tolerance, String colorName) {
  // Get RGB components of the target color
  float targetR = red(targetColor);
  float targetG = green(targetColor);
  float targetB = blue(targetColor);

  // Create a binary mask for the color range
  PImage colorMask = createImage(video.width, video.height, RGB);

  for (int y = 0; y < video.height; y++) {
    for (int x = 0; x < video.width; x++) {
      color pixelColor = video.get(x, y);
      float pixelR = red(pixelColor);
      float pixelG = green(pixelColor);
      float pixelB = blue(pixelColor);

      // Calculate color distance (Euclidean distance)
      float colorDistance = dist(pixelR, pixelG, pixelB, targetR, targetG, targetB);

      // Check whether the color is within the tolerance range
      if (colorDistance < tolerance) {
        colorMask.set(x, y, color(255));
      } else {
        colorMask.set(x, y, color(0));
      }
    }
  }

  // Process the mask image
  opencv.loadImage(colorMask);
  opencv.erode();
  opencv.dilate();

  // Find contours in the mask
  ArrayList<Contour> contours = opencv.findContours();

  // Draw detected regions
  noFill();
  stroke(targetColor);
  strokeWeight(2);

  for (Contour contour : contours) {
    if (contour.area() > 100) {  // Only display sufficiently large regions
      Rectangle r = contour.getBoundingBox();

      // Draw a bounding rectangle
      rect(r.x, r.y, r.width, r.height);

      // Calculate the average color within the detected region
      color avgColor = getAverageColor(video, r);

      // Display color name and RGB values above the region
      fill(targetColor);
      textAlign(CENTER, CENTER);
      String info = colorName + "\nR:" + (int)red(avgColor) +
        " G:" + (int)green(avgColor) +
        " B:" + (int)blue(avgColor);
      text(info, r.x + r.width/2, r.y - 20);
    }
  }
}

// Calculate the average color of a rectangular region
color getAverageColor(PImage img, Rectangle r) {
  float rSum = 0, gSum = 0, bSum = 0;
  int count = 0;

  // Ensure the region stays within image bounds
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
