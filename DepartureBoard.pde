class DepartureBoard {
  ArrayList<Flights> arrivals;
  int startIndex; // Index of the first element to display
  int displayCount; // Number of elements to display

  DepartureBoard() {
    arrivals = new ArrayList<Flights>();
    startIndex = 0;
    displayCount = 10;
  }

  void update(ArrayList<Flights> arrivals) {
    this.arrivals = arrivals;
  }

void draw() {
  textAlign(LEFT, TOP);
  fill(0);
  int yOffset = 100;
  int rowHeight = 20;
  for (int i = startIndex; i < min(startIndex + displayCount, arrivals.size()); i++) {
    Flights flight = arrivals.get(i);
    String flightInfo = flight.getFlightDate() + " | " + flight.getAirlineCode() + " | " + flight.getFlightNumber(); // Customize this based on your flight data
    text(flightInfo, width / 2 - 200, yOffset);
    yOffset += rowHeight;
  }
}


  void scroll(int increment) {
    startIndex = constrain(startIndex + increment, 0, max(0, arrivals.size() - displayCount));
  }
}
