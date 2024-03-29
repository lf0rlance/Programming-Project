// Reference: https://processing.org/examples/animatedsprite.html
class Animation {
  PImage[] frames; // Array to store individual frames of the animation
  int frameCount; // Total number of frames in the animation
  int currentFrameIndex; // Index of the current frame being displayed
  int frameDelay; // Delay between frame updates
  int frameCounter; // Counter to track frame updates

  Animation(String folderName, String imagePrefix, int count, int delay) {
    frameCount = count;
    frames = new PImage[frameCount];
    frameDelay = delay;
    frameCounter = 0;

    // Load all frames of the animation from the specified folder
    for (int i = 0; i < frameCount; i++) {
      String filename = folderName + "/" + imagePrefix + "(" + (i + 1) + ").jpg"; // Assuming the image filenames are in the format "Layer (1).jpg", "Layer (2).jpg", etc.
      frames[i] = loadImage(filename);
    }

    currentFrameIndex = 0; // Initialize the current frame index
  }

  void display(float x, float y) {
    // Display the current frame at the specified position
    image(frames[currentFrameIndex], x, y);
  }

  void update() {
    // Increment the frame counter
    frameCounter++;

    // Check if it's time to update the frame
    if (frameCounter >= frameDelay) {
      // Reset the frame counter
      frameCounter = 0;
      
      // Increment the frame index to display the next frame
      currentFrameIndex = (currentFrameIndex + 1) % frameCount;
    }
  }
}
