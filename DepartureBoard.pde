class DepartureBoard {
  ArrayList<Flights> arrivals;
  int startIndex; // Index of the first element to display
  int displayCount; // Number of elements to display
  boolean departureBoardUpdated; // Flag indicating whether departure board has been updated

  DepartureBoard() {
    arrivals = new ArrayList<Flights>();
    startIndex = 0;
    displayCount = 8;              // amount of lines we want before scroll is needed
    departureBoardUpdated = false; // Initialize to false
  }

  void update(ArrayList<Flights> arrivals) {
    this.arrivals = arrivals;
    departureBoardUpdated = true; // Set the flag to true when updated
  }

  void draw() {
    textAlign(LEFT, TOP);
    textSize(20);
    int tableWidth = 800; // Width of the table
    int columnWidth = (tableWidth - 250) / 5; // Width of each column reduced by 20 pixels
    int rowHeight = 30;
    int xOffset = (width - tableWidth) / 2 + 160; // Center the table horizontally and shift by 160 pixels
    int yOffset = 200;

    // Draw table headers only if departure board has been updated
    if (departureBoardUpdated) {
      // Draw table headers
      fill(0);
      text("Time", xOffset, yOffset);
      text("Destination", xOffset + columnWidth, yOffset);
      text("Flight No.", xOffset + 2 * columnWidth, yOffset);
      text("Airline", xOffset + 3 * columnWidth, yOffset);
      text("Status", xOffset + 4 * columnWidth, yOffset);
    }

    // Draw table rows
    yOffset += rowHeight; // Move down one row for the first data row
    for (int i = startIndex; i < min(startIndex + displayCount, arrivals.size()); i++) {
      Flights flight = arrivals.get(i);
      fill(0); // Reset fill color to black for other columns
      text(flight.getDepTime(), xOffset, yOffset); // Departure Time
      text(flight.getDestination(), xOffset + columnWidth, yOffset); // Destination
      text(flight.getFlightNumber(), xOffset + 2 * columnWidth, yOffset); // Flight Number
      text(flight.getAirlineCode(), xOffset + 3 * columnWidth, yOffset); // Airline Code
      String status = "On Time"; // Default status
      if ((flight.getCancelled() == 1) || ((flight.getDiverted() == 1) && flight.getCancelled() == 1)) {
        status = "Cancelled";
        fill(255, 0, 0); // Red font for Cancelled status
      } else if (flight.getDiverted() == 1) {
        status = "Diverted";
        fill(255, 255, 0); // Yellow font for Diverted status
      } else {
        fill(0, 255, 0); // Green font for On Time status
      }
      text(status, xOffset + 4 * columnWidth, yOffset); // Status
      yOffset += rowHeight; // Move down to the next row
    }
    textSize(30);
  }

  void scroll(int increment) {
    startIndex = constrain(startIndex + increment, 0, max(0, arrivals.size() - displayCount));
  }
}
