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
  
  // Updated suggestion list declaration
  ArrayList<String> suggestionList = new ArrayList<>();
  

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
     
     if (typing) {
            displaySuggestions();
     }
  }

 void mousePressed() {
    if (typing) {
      // Check if the mouse is over the suggestion list
      if (mouseOverSuggestionList()) {
        // Determine the index of the clicked suggestion
        int index = (mouseY - (searchBarY + 40)) / 32; // Height of each suggestion item is 32
        // Check if the index is valid
        if (index >= 0 && index < suggestionList.size()) {
          // Set the searchText to the selected suggestion
          searchText = suggestionList.get(index);
          // Stop typing
          stopTyping();
          // Perform the action associated with pressing Enter
          performEnterAction();
        }
      } else if (searchText.isEmpty()) {
        // Clear suggestion list only if search text is empty and clicked outside the search bar
        stopTyping();
      }
    }
  }

  boolean mouseOverSuggestionList() {
        float suggestionX = searchBarX;
        float suggestionY = searchBarY + 60;
        float suggestionWidth = searchBarWidth;
        float suggestionHeight = suggestionList.size() * 30;

        return mouseX > suggestionX && mouseX < suggestionX + suggestionWidth && mouseY > suggestionY && mouseY < suggestionY + suggestionHeight;
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
      // Calculate the width of the text including the new character
      float newTextWidth = textWidth(searchText + key);
      // Check if the new text width exceeds the search bar width
      if (newTextWidth <= searchBarWidth - 75) {
        searchText += key;
        updateSuggestions();
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
        updateSuggestions();
      } else if (!previousSearchTexts.isEmpty()) {
        // If searchText is empty, restore the previous search text
        searchText = previousSearchTexts.remove(previousSearchTexts.size() - 1);
        updateSuggestions();
      }
    }
  }
  
  void performEnterAction() {
    // Placeholder for the action associated with pressing Enter
    println("Entered suggestion: " + searchText);
    // Add your desired action here, such as submitting the search or performing any other task associated with pressing Enter
  }
  
  
 void updateSuggestions() {
    suggestionList.clear();
    ArrayList<String> addedSuggestions = new ArrayList<>(); // List to keep track of added suggestions

    // Fetch suggestions based on the current searchText
    int count = 0; // Counter to track the number of suggestions added
    for (Flights flight : allFlightData) {
        // Check if the destination starts with the searchText and is not already in the addedSuggestions list
        if (flight.getDestination().toLowerCase().startsWith(searchText.toLowerCase()) && !addedSuggestions.contains(flight.getDestination())) {
            // Add matching destinations to the suggestion list
            suggestionList.add(flight.getDestination());
            addedSuggestions.add(flight.getDestination()); // Add the suggestion to the addedSuggestions list
            count++; // Increment the counter
            // Break the loop if three suggestions have been added
            if (count == 5) {
                break;
            }
        }
    }
}
    void displaySuggestions() {
        // Placeholder for displaying suggestion list
        // Draw the suggestion list below the search bar
        if (!suggestionList.isEmpty()) {
            float suggestionX = searchBarX;
            float suggestionY = searchBarY + 40;
            float suggestionWidth = searchBarWidth;
            float suggestionHeight = suggestionList.size() * 32;

            fill(240);
            rect(suggestionX, suggestionY, suggestionWidth, suggestionHeight, 10);

            fill(0);
            textAlign(LEFT, TOP);
            for (int i = 0; i < suggestionList.size(); i++) {
                text(suggestionList.get(i).toString(), suggestionX + 10, suggestionY + 5 + i * 30);
            }
        }
    }

 

  String getSearchText() {
    return searchText.toLowerCase();
  }
}
