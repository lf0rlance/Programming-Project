class DepartureBoard {
  ArrayList<Flights> departures; 
  int startIndex; // Index of the first element to display
  int displayCount; // Number of elements to display
  boolean departureBoardUpdated;
  int hoveredFlightIndex = -1; 

  DepartureBoard() {
    departures = new ArrayList<Flights>(); 
    startIndex = 0;
    displayCount = 8;              // amount of lines we want before scroll is needed
    departureBoardUpdated = false; 
  }

  void update(ArrayList<Flights> departures) {
    this.departures = departures; 
    departureBoardUpdated = true; 
  }

void draw() {
  textAlign(LEFT, TOP);
  textSize(20);
  int tableWidth = 800; // Width of the table
  int columnWidth = (tableWidth - 250) / 6; // Width of each column
  int rowHeight = 30;
  int xOffset = (width - tableWidth) / 2 + 150; 
  int yOffset = 220;

  if (departureBoardUpdated) {
    image(destinationTableImage, xOffset - 20, yOffset - 28); 
    fill(0);
    text("Date", xOffset - 10, yOffset); 
    text("Time", xOffset + columnWidth, yOffset);
    int destinationXOffset = xOffset + 2 * columnWidth - 5;
    text("Destination", destinationXOffset, yOffset); 
    text("Flight No.", xOffset + 3 * columnWidth, yOffset);
    text("Airline", xOffset + 4 * columnWidth, yOffset);
    text("Status", xOffset + 5 * columnWidth, yOffset);
  }

  // Draw table rows
  yOffset += rowHeight; 
  boolean mouseOverDelayedFlight = false; 
  for (int i = startIndex; i < min(startIndex + displayCount, departures.size()); i++) {
    Flights flight = departures.get(i);
    fill(0);
    String flightDate = formatDate(flight.getFlightDate()); // Format the flight date
    text(flightDate, xOffset - 10, yOffset);
    
    // Format the time
    String depTime = formatTime(flight.getDepTime());
    text(depTime, xOffset + columnWidth, yOffset); // Departure Time
    
    int destinationXOffset = xOffset + 2 * columnWidth - 5;
    text(flight.getDestination(), destinationXOffset, yOffset); // Destination
    
    text(flight.getFlightNumber(), xOffset + 3 * columnWidth, yOffset); // Flight Number
    text(flight.getAirlineCode(), xOffset + 4 * columnWidth, yOffset); // Airline Code
    
    // Calculate delay
    int delay = flight.getDepTime() - flight.getCrsDepTime();
    
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
      if (mouseX >= (xOffset + 5 * columnWidth) + 20 && mouseX <= (xOffset + 6 * columnWidth) - 20 &&
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

  if (!mouseOverDelayedFlight) {
    hoveredFlightIndex = -1;
  }

  // Display delay box
  if (hoveredFlightIndex != -1) {
    Flights hoveredFlight = departures.get(hoveredFlightIndex);
    int delay = hoveredFlight.getDepTime() - hoveredFlight.getCrsDepTime();
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
    String datePart = dateAndTime[0];
    
    // Split the date part by "/"
    String[] parts = datePart.split("/");
    
    String month = addLeadingZero(parts[0]);
    String day = addLeadingZero(parts[1]);
    String year = parts[2].substring(2); // Extract last two digits of the year
    
    return month + "/" + day + "/" + year;
  }
  
  // Method to add zeros
  String addLeadingZero(String input) {
    int number = Integer.parseInt(input);
    
    return (number < 10) ? "0" + number : String.valueOf(number);
  }
  
  String formatTime(int time) {
    String timeStr = String.valueOf(time);
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
    startIndex = constrain(startIndex + increment, 0, max(0, departures.size() - displayCount));
  }
}
