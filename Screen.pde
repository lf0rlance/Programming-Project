class Screen {
  ArrayList<Widget> screenWidgets;
  color screenColor;
  int cloudX = 0; // Initial x-coordinate of the cloud
 
  Screen(color screenColor) {
    screenWidgets = new ArrayList<>();
    this.screenColor = screenColor;
  }
  
  public void add(Widget theWidget) {
    screenWidgets.add(theWidget);
  }
  
  void draw() {
    background(screenColor);
    for (Widget aWidget : screenWidgets) {
      aWidget.draw();
    }
    if (this != menuScreen) {
      drawBackButton(); // Draw the back button only if not on the menu screen
    }
  }
  
  public int getEvent(int mX, int mY) {
    for (Widget aWidget : screenWidgets) {
      int event = aWidget.getEvent(mX, mY);
      if (event != EVENT_NULL) return event;
    }
    return EVENT_NULL;
  }
  
  public ArrayList<Widget> getWidgets() {
    return screenWidgets; 
  }
  
  void updateCloudPosition() {
    // Adjust the speed of cloud movement by changing the value of cloudSpeed
    float cloudSpeed = 1;
    cloudX = (int)((cloudX + cloudSpeed) % width); // Update the cloud's x position with wrapping
  }

  int getCloudX() {
    return cloudX;
  }

  void drawBackButton() {
    // Define position and size of the back button
    int backButtonSize = 40;
    int backButtonPadding = 500;
    int backButtonX = backButtonSize - 30;
    int backButtonY = backButtonPadding;
  
    // Check if the mouse is over the back button
    boolean mouseOverBackButton = mouseX > backButtonX && mouseX < backButtonX + backButtonSize &&
                                  mouseY > backButtonY && mouseY < backButtonY + backButtonSize;
  
    // Change button color based on mouse interaction
    if (mouseOverBackButton) {
      fill(0, 122, 210); // Light blue when mouse is over
    } else {
      fill(3, 145, 200);    // Darker blue otherwise
    }
    ellipse(backButtonX + backButtonSize / 2, backButtonY + backButtonSize / 2, backButtonSize, backButtonSize);
  
    // Draw the white back arrow inside the circle
    fill(255);
    float arrowSize = 0.6f * backButtonSize;
    float arrowOffset = 0.2f * backButtonSize;
    float arrowX1 = backButtonX + backButtonSize / 2 + arrowOffset;
    float arrowY1 = backButtonY + backButtonSize / 2 - arrowSize / 2;
    float arrowX2 = backButtonX + backButtonSize / 2 + arrowOffset;
    float arrowY2 = backButtonY + backButtonSize / 2 + arrowSize / 2;
    float arrowX3 = backButtonX + backButtonSize / 2 - arrowSize / 2 + arrowOffset;
    float arrowY3 = backButtonY + backButtonSize / 2;
    triangle(arrowX1 - 3, arrowY1, arrowX2 - 3, arrowY2, arrowX3 - 3, arrowY3);
    
  
    // Check if the mouse clicks on the back button
    if (mouseOverBackButton && mousePressed) {
      audio1.play();
      audio2.play();
      // Switch to the main screen
      currentScreen = menuScreen;
    }
  }
  
  public void overWidgetCheck(Screen theScreen)
  {
    ArrayList widgets = theScreen.getWidgets();
    for(int i = 0; i < widgets.size(); i++)
    {
      Widget theWidget = (Widget) widgets.get(i);
      if(theWidget.getEvent(mouseX, mouseY) != EVENT_NULL)
      {
        theWidget.mouseOver();
      }
      else theWidget.mouseNotOver();
    }
  }
  
}
