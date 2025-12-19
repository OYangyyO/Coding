
import processing.video.*;                                    // Import the video library for camera display

PFont chineseFont;                                            // Font object
Capture cam;                                                  // Camera object
String[] cameras;                                             // List of available cameras
int selectedCameraIndex = 0;                                  // Default selected camera index

void setup() {
  size(640, 480);                                             // Set display window size
  chineseFont = createFont("Dialog", 24);
  textFont(chineseFont);
  
  cameras = Capture.list();                                   // Get all available cameras
  // Print the number and information of detected cameras ---------------
  println("Found " + cameras.length + " camera(s):");
  for (int i = 0; i < cameras.length; i++) {
    println(i + ": " + cameras[i]);
  }
  if (cameras.length == 0) {                                  // Check if any camera is available
    println("No camera detected!");
    exit();
  } else {
    initCamera(selectedCameraIndex);                          // Initialize the selected camera
  }
}

void draw() {
  if (cam != null && cam.available()) {
    cam.read();
    image(cam, 0, 0, width, height);
  }

  // Display the current camera information
  fill(0);
  text("Current camera: " + selectedCameraIndex + " (Press number keys to switch)", 10, 30);
}

// Initialize camera ------------------------------
void initCamera(int index) {
  index = constrain(index, 0, cameras.length - 1);            // Ensure index is within valid range
  if (cam != null) {                                          // Stop previous camera if it exists
    cam.stop();
  }
  cam = new Capture(this, cameras[index]);                    // Create a new camera object
  cam.start();
  selectedCameraIndex = index;
  println("Switched to camera " + index);
}

// Keyboard input detection -------------------------------
void keyPressed() {
  if (key >= '0' && key <= '9') {                            // Check if a number key is pressed
    int num = key - '0';                                     // Convert the character to an integer index
    if (num < cameras.length) {
      initCamera(num);
    }
  }
}
