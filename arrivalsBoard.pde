  /** Author: Adam
  *  
  *  References:
  *  https://www.youtube.com/watch?v=_6_zAtrWl8o
  *  https://youtu.be/4JzDttgdILQ?si=ilPK2c0ncet8fhIw
  *  Processing- A programing handbook for visual designers and artists Casey Reas & Bean Fry
  *
  *   Contributers:
  *      Can
  */
  
class ArrivalsBoard {
  ArrayList<Flights> arrivals;
  int startIndex; // Index of the first element to display
  int displayCount; // Number of elements to display
  boolean arrivalBoardUpdated; // Indicating whether arrival board has been updated
  int hoveredFlightIndex = -1; // Index of hover

  ArrivalsBoard() {
    arrivals = new ArrayList<Flights>();
    startIndex = 0;
    displayCount = 8;              // amount of lines we want before scroll is needed
    arrivalBoardUpdated = false; 
  }

  void update(ArrayList<Flights> arrivals) { 
    this.arrivals = arrivals; 
    arrivalBoardUpdated = true; // Set the flag to true when updated
  }

  void draw() {
  textAlign(LEFT, TOP);
  textSize(20);
  int tableWidth = 800; // Width of the table
  int columnWidth = (tableWidth - 250) / 6; // Width of each column
  int rowHeight = 30;
  int xOffset = (width - tableWidth) / 2 + 150; 
  int yOffset = 220; 

  // Draw table headers only if arrival board has been updated
  if (arrivalBoardUpdated) {
    image(arrivalBoardImage, xOffset - 20, yOffset - 28); // Draw the image at the position of the date header
    fill(0);
    text("Date", xOffset - 10, yOffset); 
    text("Time", xOffset + columnWidth, yOffset);
    int originXOffset = xOffset + 2 * columnWidth - 5; 
    text("Origin", originXOffset, yOffset);              // Draw headders
    text("Flight No.", xOffset + 3 * columnWidth, yOffset);
    text("Airline", xOffset + 4 * columnWidth, yOffset);
    text("Status", xOffset + 5 * columnWidth, yOffset);
  }

  // Draw table rows
  yOffset += rowHeight; // Move down one row for the first data row
  boolean mouseOverDelayedFlight = false; // Flag to track if the mouse is over any delayed flight
  for (int i = startIndex; i < min(startIndex + displayCount, arrivals.size()); i++) {
    Flights flight = arrivals.get(i);
    fill(0); // Reset fill color
    String flightDate = formatDate(flight.getFlightDate()); // Orders by date
    text(flightDate, xOffset - 10, yOffset); 

    // Format the time
    String arrTime = formatTime(flight.getArrTime());
    text(arrTime, xOffset + columnWidth, yOffset); 

    int originXOffset = xOffset + 2 * columnWidth - 5; 
    text(flight.getOrigin(), originXOffset, yOffset); 

    text(flight.getFlightNumber(), xOffset + 3 * columnWidth, yOffset); // Flight Number
    text(flight.getAirlineCode(), xOffset + 4 * columnWidth, yOffset); // Airline Code

    // Calculate delay
    int delay = flight.getArrTime() - flight.getCrsArrTime();

    // Determine status
    String status;
    if ((flight.getCancelled() == 1) || ((flight.getDiverted() == 1) && flight.getCancelled() == 1)) {
      status = "Cancelled";
      fill(255, 0, 0); // Red font for cancelled status
    } else if (flight.getDiverted() == 1) {
      status = "Diverted";
      fill(255, 255, 0); // Yellow font for diverted status
    } else if (delay > 10) { // only declaring delayed if the delay is above 10 mins
      status = "Delayed";
      fill(255, 165, 0); // Orange font for Delayed status
      // Check if mouse is over the "Status" column and the row of the delayed flight
      if (mouseX >= (xOffset + 5 * columnWidth) - 40 && mouseX <= (xOffset + 6 * columnWidth) - 20 &&
          mouseY >= yOffset && mouseY <= yOffset + rowHeight) {
        hoveredFlightIndex = i; 
        mouseOverDelayedFlight = true;
      }
    } else {
      status = "On Time"; 
      fill(0, 255, 0); // Green font for On Time status
    }
    int statusXOffset = xOffset + 5 * columnWidth - 7; 
    text(status, statusXOffset, yOffset);
    yOffset += rowHeight; // Move down to the next row
  }

  // Resets the hoveredFlightIndex if mouse is not delayed flight
  if (!mouseOverDelayedFlight) {
    hoveredFlightIndex = -1;
  }

  // Display delay box if hovering over a delayed flight
  if (hoveredFlightIndex != -1) {
    Flights hoveredFlight = arrivals.get(hoveredFlightIndex);
    int delay = hoveredFlight.getArrTime() - hoveredFlight.getCrsArrTime();
    if (delay > 0) {
      fill(255);
      rect(mouseX + 15, mouseY + 15, 120, 30, 5); 
      fill(0); 
      text("Delay: " + delay + " mins", mouseX + 20, mouseY + 20, 120, 30); 
    }
  }

  textSize(30);
}
  
  // Method to format date as MM/DD/YY
  String formatDate(String flightDate) {
    String[] dateAndTime = flightDate.split(" ");
    
    // Extract the date part from the split
    String datePart = dateAndTime[0];
    
    // Split the date part by "/"
    String[] parts = datePart.split("/");
    
    String month = addLeadingZero(parts[0]);
    String day = addLeadingZero(parts[1]);
    String year = parts[2].substring(2); // Extract last two digits of the year
    
    return month + "/" + day + "/" + year;
  }
  
  // Adds leading zeros
  String addLeadingZero(String input) {
    // Convert the input to integers
    int number = Integer.parseInt(input);
    
    // Check if the number is less than 10, if so add zero's
    return (number < 10) ? "0" + number : String.valueOf(number);
  }
  
  // Method to format time
  String formatTime(int time) {
    String timeStr = String.valueOf(time);
    // Add leading zero if time has only three digits
    if (timeStr.length() == 3) {
      timeStr = "0" + timeStr;
    }
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
