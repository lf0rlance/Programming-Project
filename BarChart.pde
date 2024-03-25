class BarChart {
  
  int dataType;
  String title;
  
  int xpos;
  int ypos;
  int startingIndex;
  
  final int BAR_HEIGHT = 45; // Height of each bar
  final int MAX_DISPLAY = 5; // Maximum number of bars to display
  
  ArrayList<String> dataList;
  IntList frequency;
  
  final int FLIGHT_DATE = 1;
  final int AIRLINE_CODE = 2;
  final int FLIGHT_NUMBER = 3;
  final int ORIGIN = 4;
  final int ORIGIN_CITY_NAME = 5;
  final int ORIGIN_STATE =  6;
  final int ORIGIN_WAC = 7;
  final int DESTINATION = 8;
 
  BarChart(int xpos, int ypos, int dataType) {
    startingIndex = 0;
    this.xpos = xpos;
    this.ypos = ypos;
    this.dataType = dataType;
    
    /* Creates an ArrayList of the data type */
    dataList = new ArrayList<String>();            
    for (int i = 0; i < allFlightData.length; i++) {
      boolean found = false;
      Flights currentFlight = allFlightData[i];
      String data = getData(currentFlight); // gets the required data for the flight(e.g origin city, destination)
      
      for (String temp: dataList) {
        if (data.equals(temp)) found = true; // if data is already in the dataList, found = true
      }
      if (!found) dataList.add(data); // only adds data to the data list if the dataList does not have the data already.
                                      // (e.g if t "Dublin" is added to dataList once, it will not be added again.)
    }
    
    /* Creates an ArrayList of the frequency of each data type */
    frequency = new IntList();         
    for (int i = 0; i < dataList.size(); i++) {
      int count = 0;
      String currentString = dataList.get(i); 
      for (Flights currentFlight: allFlightData) { // itterates through each flight in the allFlightData array
        String data = getData(currentFlight);
        if (data.equals(currentString)) count += 1; //  counts how many times the data in dataList appears in the allFlightData array
      }
      frequency.append(count); // the total count is stored in the frequency arrayList
    }
  }
  
  public void draw() {
    int displayCount = Math.min(MAX_DISPLAY, dataList.size() - startingIndex);
    int actualIndex = 0; // the positioning of each bar( 0 = first bar, 1 = second bar etc);
    for (int i = startingIndex; i < startingIndex + displayCount; i++) {
      
      // Extracting label and count data
      String label = dataList.get(i);  
      int count = frequency.get(i);      // get data and corresponding frequency
      
      // Setting colors based on specified values
      if (count <= 20) {
        fill(#0b1e33);  // Dark blue
      } else if (count <= 40) {
        fill(#013c58);  // Dark green
      } else if (count <= 60) {
        fill(#00537a);  // Dark turquoise
      } else if (count <= 80) {
        fill(#f5a201);  // Dark yellow
      } else {
        fill(#ffba42);  // Light orange
      }
      
      // Drawing the bar
      rect(xpos, ypos + actualIndex * BAR_HEIGHT, count, 20);
      
      // Drawing labels
      fill(0);
      text(label, 225, 205 + actualIndex * BAR_HEIGHT);
      text(count, 600, 210 + actualIndex * BAR_HEIGHT);
      text(title, 225, ypos - 30);
      actualIndex += 1;
    }
  }
  
  public void scroll(int increment) {
    int maxIndex = Math.max(0, dataList.size() - MAX_DISPLAY); // Maximum starting index to prevent scrolling past the last data
    startingIndex = constrain(startingIndex + increment, 0, maxIndex);
  }
  
  public String getData(Flights flight) {
    switch(dataType) {
      case FLIGHT_DATE:
        title = "Flight Date";
        return flight.getFlightDate();
      case AIRLINE_CODE:
        title = "Airline Code";
        return flight.getAirlineCode();
      case FLIGHT_NUMBER:
        title = "Flight Number";
        return String.valueOf(flight.getFlightNumber());
      case ORIGIN:
        title = "Origin";
        return flight.getOrigin();
      case ORIGIN_CITY_NAME:
        title = "Origin City Name";
        return flight.getOriginCityName();
      case ORIGIN_STATE:
        title = "Origin State";
        return flight.getOriginState();
      case ORIGIN_WAC:
        title = "Origin WAC";
        return String.valueOf(flight.getOriginWac());
      case DESTINATION:
        title = "Destination";
        return flight.getDestination();
      default:
        return "";
    }
  }
}
