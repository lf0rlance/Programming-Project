// Reference: https://processing.org/examples/animatedsprite.html
  /** Author: Adam
  *
  */
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
      if (folderName == "airportAnimation") {
        String filename = folderName + "/" + imagePrefix + "(" + (i + 1) + ").jpg"; // Assuming jpg
        frames[i] = loadImage(filename);
      } else {
        String filename = folderName + "/" + imagePrefix + "(" + (i + 1) + ").png"; // Assuming png
        frames[i] = loadImage(filename);
      }
    }
    currentFrameIndex = 0;
  }

  void display(float x, float y) {
    // Display the current frame at the specified position
    image(frames[currentFrameIndex], x, y);
  }

  void update() {
    // Decrement the frame counter
    frameCounter--;

    // Check if it's time to update the frame
    if (frameCounter <= 0) {
        // Reset the frame counter
        frameCounter = frameDelay;

        // Decrement the frame index to display the previous frame
        currentFrameIndex--;
        
        // Ensure the frame index stays within bounds
        if (currentFrameIndex < 0) {
            currentFrameIndex = frameCount - 1;
        }
    }  
  }
}
  
