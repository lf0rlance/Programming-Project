class BarChart {
  String title;    // title of the bar chart
  int dataType;    // data being displayed on the barchart
  int xpos;
  int ypos;
  int startingIndex;  
  final int BAR_HEIGHT = 45; // Height of each bar
  final int MAX_DISPLAY = 5; // Maximum number of bars to display 
  final int SELECT_GRAPH = -1;
  final int FLIGHT_DATE = 1;
  final int AIRLINE_CODE = 2;
  final int FLIGHT_NUMBER = 3;
  final int ORIGIN = 4;
  final int ORIGIN_CITY_NAME = 5;
  final int ORIGIN_STATE =  6;
  final int ORIGIN_WAC = 7;
  final int DESTINATION = 8;
  boolean displayDropMenu;
  ArrayList<String> dataList;
  
  
  IntList frequency; 
  color dropMenuColor = color(#f5a201);
  color widgetColor = color(255);
  
  Widget dropMenu;
  Widget[] widgetList = new Widget[8];
 
  BarChart(int xpos, int ypos, int dataType) {
    startingIndex = 0;
    this.xpos = xpos;
    this.ypos = ypos;
    setData(dataType);
    displayDropMenu = false;
    dropMenu = new Widget(545, 150, 250, 40,title, dropMenuColor, stdFont,SELECT_GRAPH);     // the event of each button is the same as the dataType
    
    //widgetList[0] = dropMenu;
    widgetList[0] = new Widget(dropMenu.x, dropMenu.y ,dropMenu.width ,dropMenu.height ,"Flight Date",color(255),stdFont,FLIGHT_DATE);
    widgetList[1] = new Widget(dropMenu.x, dropMenu.y ,dropMenu.width ,dropMenu.height ,"Airline Code",color(255),stdFont,AIRLINE_CODE);
    widgetList[2] = new Widget(dropMenu.x, dropMenu.y ,dropMenu.width ,dropMenu.height ,"Flight Number",color(255),stdFont,FLIGHT_NUMBER);
    widgetList[3] = new Widget(dropMenu.x, dropMenu.y ,dropMenu.width ,dropMenu.height ,"Origin",color(255),stdFont,ORIGIN);
    widgetList[4] = new Widget(dropMenu.x, dropMenu.y ,dropMenu.width ,dropMenu.height ,"Origin City Name",color(255),stdFont,ORIGIN_CITY_NAME);
    widgetList[5] = new Widget(dropMenu.x, dropMenu.y ,dropMenu.width ,dropMenu.height ,"Origin State",color(255),stdFont,ORIGIN_STATE);
    widgetList[6] = new Widget(dropMenu.x, dropMenu.y ,dropMenu.width ,dropMenu.height ,"Origin WAC",color(255),stdFont,ORIGIN_WAC);
    widgetList[7] = new Widget(dropMenu.x, dropMenu.y ,dropMenu.width ,dropMenu.height ,"Destination",color(255),stdFont,DESTINATION);   
  }

  public void drawWidgets()
  {
     dropMenu.draw();
     if(displayDropMenu)   
     {
       /* Draws an down arrow if the Drop Menu is activated*/ //later move to its own function to clean up code
       line(dropMenu.x + dropMenu.width - 40, dropMenu.y+10,
       dropMenu.x + dropMenu.width - 25, dropMenu.y+30);
       line(dropMenu.x + dropMenu.width - 25, dropMenu.y+30,
       dropMenu.x + dropMenu.width -10, dropMenu.y+10);
       
       for(int i = 0; i < widgetList.length;i++)
       {
        Widget currentWidget = widgetList[i];
        if(mouseX > currentWidget.x && mouseX < currentWidget.x + currentWidget.width && mouseY > currentWidget.y && mouseY < currentWidget.y +currentWidget.height) 
        { 
        currentWidget.widgetColor = color(200); // if mouse hovers over the widget, the widget turns grey
        }
        else
        {
           currentWidget.widgetColor = widgetColor;
        }
         // draws each of the widgets in the dropMenu
         currentWidget.y=(dropMenu.y + (i+1)*dropMenu.height );
         currentWidget.draw();
       }  
     } else {
       /* draws a up arrow if drop menu is not activated*/
      line(dropMenu.x + dropMenu.width - 40, dropMenu.y+30,
      dropMenu.x + dropMenu.width - 25, dropMenu.y+10);
      line(dropMenu.x + dropMenu.width - 25, dropMenu.y+10,
      dropMenu.x + dropMenu.width -10, dropMenu.y+30);
     }
  }

public void sort(ArrayList<String> locations, IntList amountOfFlights) {
    // Check if both lists have the same size
   if (locations.size() != amountOfFlights.size()) {
        throw new IllegalArgumentException("Lists must have the same size");
    }
    // Bubble sort algorithm to sort the locations based on the amount of flights in descending order
    for (int currentLocationIndex = 0; currentLocationIndex < amountOfFlights.size() - 1; currentLocationIndex++) {
        for (int nextLocationIndex = 0; nextLocationIndex < amountOfFlights.size() - currentLocationIndex - 1; nextLocationIndex++) {
            if (amountOfFlights.get(nextLocationIndex) < amountOfFlights.get(nextLocationIndex + 1)) {
                // Swap locations
                String tempLocation = locations.get(nextLocationIndex);
                locations.set(nextLocationIndex, locations.get(nextLocationIndex + 1));
                locations.set(nextLocationIndex + 1, tempLocation);
                // Swap amountOfFlights
                int tempAmount = amountOfFlights.get(nextLocationIndex);
                amountOfFlights.set(nextLocationIndex, amountOfFlights.get(nextLocationIndex + 1));
                amountOfFlights.set(nextLocationIndex + 1, tempAmount);
            }
        }
    }
}

  public void draw() {
    int displayCount = Math.min(MAX_DISPLAY, dataList.size() - startingIndex);
    int actualIndex = 0; // the positioning of each bar( 0 = first bar, 1 = second bar etc);
    for (int i = startingIndex; i < startingIndex + displayCount; i++) {
      // Extracting label and count data
      String label = dataList.get(i);  
      int count = frequency.get(i); // get data and corresponding frequency
      
      float scale = (float) count / frequency.get(0); // calculate color/size scale
      int redComponent = (int) (scale * 225);
      int blueComponent = 225 - redComponent;
      fill(redComponent, 0, blueComponent);

      // Drawing the bar
      rect(xpos, ypos + actualIndex * BAR_HEIGHT, scale*230, 20);
      // Drawing labels
      fill(0);
      int characterOffset;
      if (label.length() > 18) {characterOffset = (label.length() -18)*5+5;} else {characterOffset = 0;}
      text(label, xpos-100-characterOffset, 205 + actualIndex * BAR_HEIGHT);
      text(count, xpos+275, 210 + actualIndex * BAR_HEIGHT);
      text("Frequency", xpos+275, ypos-30);
      text(title, xpos-100, ypos - 30);
      actualIndex += 1;
    } 
    // Drawing Widgets
    drawWidgets();
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
  
  public void setData(int dataType)
  {
    this.dataType = dataType;
     /* Creates an ArrayList of the data type */
    dataList = new ArrayList<String>();    
    /* Creates an ArrayList of the frequency of each data type */
    frequency = new IntList();   
    for (int i = 0; i < allFlightData.length; i++) {
      boolean found = false;
      Flights currentFlight = allFlightData[i];
      String data = getData(currentFlight); // gets the required data for the flight(e.g origin city, destination)
      
      for (int j = 0;  j < dataList.size();j++) { //finding locations
        String temp = dataList.get(j);
        if (data.equals(temp) && !found) 
        {
          found = true;
          frequency.add(j,1);
        } // if data is already in the dataList, found = true
      }
      if (!found) 
      {
        
        dataList.add(data); 
        frequency.append(1);
      }
      // only adds data to the data list if the dataList does not have the data already.
    }                                 // (e.g if t "Dublin" is added to dataList once, it will not be added again.)
    
    
 
    sort(dataList, frequency);
  }
  
  
  public void displayWidgets()
  {
    if(mouseX > dropMenu.x && mouseX < dropMenu.x + dropMenu.width && mouseY > dropMenu.y && mouseY < dropMenu.y +dropMenu.height) displayDropMenu = !displayDropMenu;
  }
  
  
  
  public void activateWidgets()
  {
    for(Widget  widget: widgetList)
     {
        if(displayDropMenu && mouseX > widget.x && mouseX < widget.x + widget.width && mouseY > widget.y && mouseY < widget.y +widget.height)
        {
        dataType = widget.event; //
        switch(dataType) {  
          case FLIGHT_DATE:
            title = "Flight Date";
            dropMenu.label = title;
            break;
          case AIRLINE_CODE:
            title = "Airline Code";
            dropMenu.label = title;
            break;
          case FLIGHT_NUMBER:
            title = "Flight Number";
            dropMenu.label = title;
             break;
          case ORIGIN:
            title = "Origin";
            dropMenu.label = title;
             break;
          case ORIGIN_CITY_NAME:
            title = "Origin City Name";
            dropMenu.label = title;
             break;
          case ORIGIN_STATE:
            title = "Origin State";
            dropMenu.label = title;
            break;
          case ORIGIN_WAC:
            title = "Origin WAC";
            dropMenu.label = title;
            break;
          case DESTINATION:
            title = "Destination";
            dropMenu.label = title;
            break;     
        }
        setData(dataType);  
        }
    }
  }
  
  
  
  
  
  
}
