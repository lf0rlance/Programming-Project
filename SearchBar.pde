class SearchBar {
  String searchText = "";
  boolean typing = false;
  boolean cursorVisible = false;
  int lastCursorToggle = 0;
  int cursorToggleInterval = 500; // Blinking interval in milliseconds
  int searchBarWidth = 300;
  int searchBarX = 250;
  int searchBarY = 100;

  // List to store previous search texts
  ArrayList<String> previousSearchTexts = new ArrayList<>();

  void draw() {
    fill(240);
    rect(searchBarX, searchBarY, searchBarWidth, 40, 10);
    
    // Draw the microscope icon
    image(microscopeIcon, searchBarX + 5, searchBarY + 5, 35, 35);
    
    // Draw the text inside the search bar
    fill(0);
    textAlign(LEFT, CENTER);
    text(searchText, searchBarX + 50, searchBarY + 20);
    
    // Toggle cursor visibility every cursorToggleInterval milliseconds
    if (typing && millis() - lastCursorToggle > cursorToggleInterval) {
      cursorVisible = !cursorVisible;
      lastCursorToggle = millis();
    }
    
    // Draw the cursor if it's visible
    if (typing && cursorVisible) {
      float cursorX = textWidth(searchText) + searchBarX + 50; // Calculate X position of the cursor
      stroke(0); // Set color to black
      line(cursorX, searchBarY + 5, cursorX, searchBarY + 35); // Draw the cursor line
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
    if (key != ENTER && key != BACKSPACE && key != DELETE && key != TAB && key != ESC && keyCode != 16 && keyCode != 20) { // keyCode 16 and 20 is shift and caps lock key
      // Calculate the width of the text including the new character
      float newTextWidth = textWidth(searchText + key);
      // Check if the new text width exceeds the search bar width
      if (newTextWidth <= searchBarWidth - 75) {
        searchText += key;
      } else {
        // Save the current search text to previousSearchTexts
        previousSearchTexts.add(searchText);
        // Calculate the remaining space in the search bar
        float remainingSpace = searchBarWidth - 75 - textWidth(searchText);
        // Calculate how many characters can fit in the remaining space
        int charactersToFit = (int)(remainingSpace / textWidth(String.valueOf(key)));
        // Ensure charactersToFit is within bounds
        charactersToFit = Math.min(charactersToFit, searchText.length());
        // Shift the characters to the left and add the new character
        searchText = searchText.substring(searchText.length() - charactersToFit) + key;
      }
    } else if (typing && key == BACKSPACE) {
      if (searchText.length() > 0) {
        searchText = searchText.substring(0, searchText.length() - 1);
      } else if (!previousSearchTexts.isEmpty()) {
        // If searchText is empty, restore the previous search text
        searchText = previousSearchTexts.remove(previousSearchTexts.size() - 1);
      }
    }
  }

  String getSearchText() {
    return searchText.toLowerCase();
  }
}
