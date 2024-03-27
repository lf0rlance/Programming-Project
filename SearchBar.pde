class SearchBar {
  String searchText = "";
  boolean typing = false;
  boolean cursorVisible = false;
  int lastCursorToggle = 0;
  int cursorToggleInterval = 500; // Blinking interval in milliseconds

  void draw() {
    fill(240);
    rect(250, 100, 300, 40, 10);
    
    // Draw the microscope icon
    image(microscopeIcon, 255, 105, 35, 35);
    
    // Draw the text inside the search bar
    fill(0);
    textAlign(LEFT, CENTER);
    text(searchText, 300, 120);
    
    // Toggle cursor visibility every cursorToggleInterval milliseconds
    if (typing && millis() - lastCursorToggle > cursorToggleInterval) {
      cursorVisible = !cursorVisible;
      lastCursorToggle = millis();
    }
    
    // Draw the cursor if it's visible
    if (typing && cursorVisible) {
      float cursorX = textWidth(searchText) + 300; // Calculate X position of the cursor
      stroke(0); // Set color to black
      line(cursorX, 105, cursorX, 135); // Draw the cursor line
    }
  }

  void startTyping() {
    typing = true;
  }

  void stopTyping() {
    typing = false;
    cursorVisible = false;
  }

  void keyPressed() {
    if (key != ENTER && key != BACKSPACE && key != DELETE && key != TAB && key != ESC) {
      if (key >= 'A' && key <= 'Z' && !keyPressed) {
        key = Character.toLowerCase(key);
      }
      searchText += key;
    } else if (typing && key == BACKSPACE && searchText.length() > 0) {
      searchText = searchText.substring(0, searchText.length() - 1);
    }
  }

  String getSearchText() {
    return searchText.toLowerCase();
  }
}
