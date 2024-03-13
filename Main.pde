// main class
class FlightExplorer {
  ArrayList<DataPoint> flightsData;

  public void setup() {
    flightsData = DataLoader.loadData("flights.csv");
    // Add other setup code when needed
  }

  public void draw() {
    background(255);
    // Add code/functions to draw data on the screen
  }

  public void keyPressed() {
    // Handle mouse/keyboard inputs, update filters, etc.
  }

  // Other parts of the program
}
