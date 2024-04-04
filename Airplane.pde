class Airplane {
  float x, y;  // Current position
  float targetX, targetY;  // Target position
  final float speed = 0.5; // Speed of airplane
  float angle;
  float initialSize = 0.07; // Initial size of the airplane
  float finalSize = 0.04; // Final size of the airplane
  float imageSize; // Current size of the airplane image
  float halfwayDistance; // Distance from start to halfway to the destination
  boolean growing = true; // Flag to indicate whether the airplane is growing or shrinking
 
  
  
  Airplane(float startX, float startY, float targetX, float targetY) {
    this.x = startX;
    this.y = startY;
    this.targetX = targetX;
    this.targetY = targetY;
    angle = degrees(atan2(targetY - y, targetX - x));
    imageSize = initialSize; // Set initial size
    halfwayDistance = dist(startX, startY, (startX + targetX) / 2, (startY + targetY) / 2); // Calculate halfway distance
  }
  
  void update() {
    // Move airplane towards the target
    float dx = targetX - x;
    float dy = targetY - y;
    float distance = sqrt(dx * dx + dy * dy);
    
    if (distance > speed) {
      // Move closer to the target
      float ratio = speed / distance;
      x += dx * ratio;
      y += dy * ratio;
    } else {
      // Arrived at the target, reset target position
      x = targetX;
      y = targetY;
    }
     // Dynamically adjust the size of the airplane based on the distance traveled
    float traveledDistance = dist(x, y, (x + targetX) / 2, (y + targetY) / 2); // Calculate distance traveled
    if (traveledDistance < halfwayDistance) {
      // If less than halfway to the destination, grow
      imageSize = map(traveledDistance, 0, halfwayDistance, initialSize, finalSize);
    } else {
      // If more than halfway to the destination, shrink
      imageSize = map(traveledDistance, halfwayDistance, dist(x, y, targetX, targetY), finalSize, initialSize);
    }
  }
  
  void draw() {
     // Draw airplane image at its current position with rotation towards the destination
     pushMatrix();
     translate(x, y);
     rotate(radians(angle+90));
     imageMode(CENTER);
     image(airplaneImage, 0, 0, airplaneImage.width * imageSize, airplaneImage.height * imageSize);
     popMatrix();
  }
  
  boolean reachedTarget() {
    // Check if airplane has reached its target
    return x == targetX && y == targetY;
  }
  
   void resetAirplanes() {
   airplanes.clear(); // Clear existing airplanes
  
   // Create new airplanes with random starting and target positions
    for (int i = 0; i < numAirplanes; i++) {
      float startX = random(width);
      float startY = random(height);
      float targetX = random(width);
      float targetY = random(height);
      airplanes.add(new Airplane(startX, startY, targetX, targetY));
   }
  }
}
