class ArrivalsBoard {
  ArrayList<Flights> arrivals; // Updated variable name to 'arrivals'
  int startIndex; // Index of the first element to display
  int displayCount; // Number of elements to display
  boolean arrivalBoardUpdated; // Flag indicating whether arrival board has been updated
  int hoveredFlightIndex = -1; // Index of the flight being hovered over

  ArrivalsBoard() {
    arrivals = new ArrayList<Flights>(); // Updated variable name to 'arrivals'
    startIndex = 0;
    displayCount = 8;              // amount of lines we want before scroll is needed
    arrivalBoardUpdated = false; // Initialize to false
  }

  void update(ArrayList<Flights> arrivals) { // Updated variable name to 'arrivals'
    this.arrivals = arrivals; // Updated variable name to 'arrivals'
    arrivalBoardUpdated = true; // Set the flag to true when updated
  }

  void draw() {
  textAlign(LEFT, TOP);
  textSize(20);
  int tableWidth = 800; // Width of the table
  int columnWidth = (tableWidth - 250) / 6; // Width of each column reduced by 20 pixels
  int rowHeight = 30;
  int xOffset = (width - tableWidth) / 2 + 150; // Center the table horizontally and shift by 150 pixels
  int yOffset = 220; // Adjusted yOffset to align with departure board

  // Draw table headers only if arrival board has been updated
  if (arrivalBoardUpdated) {
    // Draw the "destinationTable" image
    image(arrivalBoardImage, xOffset - 20, yOffset - 28); // Draw the image at the position of the date header
    // Draw table headers including "Date" column
    fill(0);
    text("Date", xOffset - 10, yOffset); // Adjust x position for the entire table by -10 pixels
    text("Time", xOffset + columnWidth, yOffset);
    // Adjust xOffset specifically for the "Origin" header
    int originXOffset = xOffset + 2 * columnWidth - 5; // Shift "Origin" header to the left by 5 pixels
    text("Origin", originXOffset, yOffset); // Draw "Origin" header
    text("Flight No.", xOffset + 3 * columnWidth, yOffset);
    text("Airline", xOffset + 4 * columnWidth, yOffset);
    text("Status", xOffset + 5 * columnWidth, yOffset);
  }

  // Draw table rows
  yOffset += rowHeight; // Move down one row for the first data row
  boolean mouseOverDelayedFlight = false; // Flag to track if the mouse is over any delayed flight
  for (int i = startIndex; i < min(startIndex + displayCount, arrivals.size()); i++) {
    Flights flight = arrivals.get(i); // Updated variable name to 'arrivals'
    fill(0); // Reset fill color to black for other columns
    String flightDate = formatDate(flight.getFlightDate()); // Format the flight date
    text(flightDate, xOffset - 10, yOffset); // Date, adjust x position for the entire table by -10 pixels

    // Format the time
    String arrTime = formatTime(flight.getArrTime());
    text(arrTime, xOffset + columnWidth, yOffset); // Arrival Time

    // Adjust xOffset specifically for the "Origin" column
    int originXOffset = xOffset + 2 * columnWidth - 5; // Shift "Origin" column to the left by 5 pixels
    text(flight.getOrigin(), originXOffset, yOffset); // Origin

    text(flight.getFlightNumber(), xOffset + 3 * columnWidth, yOffset); // Flight Number
    text(flight.getAirlineCode(), xOffset + 4 * columnWidth, yOffset); // Airline Code

    // Calculate delay
    int delay = flight.getArrTime() - flight.getCrsArrTime();

    // Determine status
    String status;
    if ((flight.getCancelled() == 1) || ((flight.getDiverted() == 1) && flight.getCancelled() == 1)) {
      status = "Cancelled";
      fill(255, 0, 0); // Red font for Cancelled status
    } else if (flight.getDiverted() == 1) {
      status = "Diverted";
      fill(255, 255, 0); // Yellow font for Diverted status
    } else if (delay > 10) {     // only declaring delayed if the delay is above 10 mins
      status = "Delayed";
      fill(255, 165, 0); // Orange font for Delayed status
      // Check if mouse is over the "Status" column and the row of the delayed flight
      if (mouseX >= xOffset + 5 * columnWidth && mouseX <= xOffset + 6 * columnWidth &&
          mouseY >= yOffset && mouseY <= yOffset + rowHeight) {
        hoveredFlightIndex = i; // Update hovered flight index
        mouseOverDelayedFlight = true; // Set flag to true
      }
    } else {
      status = "On Time"; // Default status
      fill(0, 255, 0); // Green font for On Time status
    }
    // Adjust xOffset specifically for the data values under the "Status" column
    int statusXOffset = xOffset + 5 * columnWidth - 7; // Move the data values to the left by 7 pixels
    text(status, statusXOffset, yOffset); // Status
    yOffset += rowHeight; // Move down to the next row
  }

  // Reset hoveredFlightIndex if mouse is not over any delayed flight
  if (!mouseOverDelayedFlight) {
    hoveredFlightIndex = -1;
  }

  // Display delay box if hovering over a delayed flight
  if (hoveredFlightIndex != -1) {
    Flights hoveredFlight = arrivals.get(hoveredFlightIndex);
    int delay = hoveredFlight.getArrTime() - hoveredFlight.getCrsArrTime();
    if (delay > 0) {
      fill(255); // White fill color for the box
      rect(mouseX + 15, mouseY + 15, 120, 30, 5); // Display a box at mouse position with additional 15 pixels
      fill(0); // Black fill color for text
      text("Delay: " + delay + " mins", mouseX + 20, mouseY + 20, 120, 30); // Display delay time in the box with additional 15 pixels
    }
  }

  textSize(30);
}
  
  // Method to format date as MM/DD/YY
  String formatDate(String flightDate) {
    String[] parts = flightDate.split("/");
    String month = parts[0];
    String day = parts[1];
    String year = parts[2].substring(2); // Extract last two digits of the year
    return month + "/" + day + "/" + year;
  }
  
  // Method to format time as HH:MM
  String formatTime(int time) {
    String timeStr = String.valueOf(time);
    // Add leading zero if time has only three digits
    if (timeStr.length() == 3) {
      timeStr = "0" + timeStr;
    }
    // Replace single-digit number with "-"
    if (timeStr.length() == 1) {
      timeStr = "-";
    }
    // Insert ":" in the middle
    if (timeStr.length() >= 2) {
      return timeStr.substring(0, 2) + ":" + timeStr.substring(2);
    } else {
      return timeStr;
    }
  }

  void scroll(int increment) {
    startIndex = constrain(startIndex + increment, 0, max(0, arrivals.size() - displayCount));
  }
}
