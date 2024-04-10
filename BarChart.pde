  /** Author: Joshua
  *  
  *  
  *   Contributers:
  *      Adam, Can, Lance
  */
class BarChart {
  String title;    // title of the bar chart
  int dataType;    // data being displayed on the barchart
  int xpos;
  int ypos;
  int startingIndex;  
  final int BAR_HEIGHT = 45; // Height of each bar
  final int MAX_DISPLAY = 5; // Maximum number of bars to displa
  
  final int FLIGHT_DATE = 1;
  final int AIRLINE_CODE = 2;
  final int ORIGIN = 3;
  final int ORIGIN_CITY_NAME = 4;
  final int ORIGIN_STATE =  5;
  final int ORIGIN_WAC = 6;
  final int DESTINATION = 7;
  final int DEST_CITY_NAME = 8;
  boolean widgetClicked;
  boolean displayDropMenu;
  ArrayList<String> dataList;
  IntList frequency; 
  color dropMenuColor = color(205, 234, 248);
  color widgetColor = color(255);
  
  Widget dropMenu;
  Widget[] widgetList = new Widget[8];
 
  /** Bar Chart Constructor Class
  * Creates a bar chart that graphically showcases the frequency that a data type appears in the data set
  *  (e.g the amount of flights coming from each city)
  * the function intitialises the bar chart to whatever is passed into the dataType parameter by calling the setData() function
  *  
  *  The constructor also creates a drop down menu as well as the different widgets that are apart of the drop down menu
  * Parameters:
  *    @param x,y - coordinates of the bar chart
  *    @param dataType - the data type to be illustrated by the bar Chart
  *                      A constant integer is used to represent each dataType that can be shown. 
  */
  BarChart(int xpos, int ypos, int dataType) {
    startingIndex = 0;
    this.xpos = xpos;
    this.ypos = ypos;
    setData(dataType);
    setTitle();
    displayDropMenu = false;
    dropMenu = new Widget(545, 150, 250, 40,"Select Graph", dropMenuColor, stdFont,EVENT_NULL);     // the event of each button is the same as the dataType
    widgetList[0] = new Widget(dropMenu.x, dropMenu.y ,dropMenu.width ,dropMenu.height ,"Flight Date",color(255),stdFont,FLIGHT_DATE);
    widgetList[1] = new Widget(dropMenu.x, dropMenu.y ,dropMenu.width ,dropMenu.height ,"Airline Code",color(255),stdFont,AIRLINE_CODE);
    widgetList[2] = new Widget(dropMenu.x, dropMenu.y ,dropMenu.width ,dropMenu.height ,"Origin",color(255),stdFont,ORIGIN);
    widgetList[3] = new Widget(dropMenu.x, dropMenu.y ,dropMenu.width ,dropMenu.height ,"Origin City Name",color(255),stdFont,ORIGIN_CITY_NAME);
    widgetList[4] = new Widget(dropMenu.x, dropMenu.y ,dropMenu.width ,dropMenu.height ,"Origin State",color(255),stdFont,ORIGIN_STATE);
    widgetList[5] = new Widget(dropMenu.x, dropMenu.y ,dropMenu.width ,dropMenu.height ,"Origin WAC",color(255),stdFont,ORIGIN_WAC);
    widgetList[6] = new Widget(dropMenu.x, dropMenu.y ,dropMenu.width ,dropMenu.height ,"Destination",color(255),stdFont,DESTINATION);
    widgetList[7] = new Widget(dropMenu.x, dropMenu.y ,dropMenu.width ,dropMenu.height ,"Destination City Name",color(255),stdFont,DEST_CITY_NAME);   

  }
    /** Function for setting the data in the bar chart.
    * Iterates through the allFlightsData array and puts all the flights with the data being inspected into its own array. 
    * makes a second array of the frequency, where the number at each index of the array is the frequency of the dataType at the
    * corresponding index
    * Paramaters:
    *    @param dataType - the dataType being displayed represented by a constant number. A list of the constants are defined in the class
    * History:
    *   Efficiency:
    *      Old- two seperate nested for-loops were used to create the dataList and frequency array. Caused performance issues
    *      New - combined the two nested for-loops into one which improved the efficiency(Joshua)
    */
   
    public void setData(int dataType)
  {
    this.dataType = dataType;
     /* Creates an ArrayList of the data type */
    dataList = new ArrayList<String>();    
    /* Creates an ArrayList of the frequency of each data type */
    frequency = new IntList(); 
    
    for (int i = 0; i < allFlightData.length; i++) {
      Flights currentFlight = allFlightData[i];
      String data = getData(currentFlight); // gets the required data for the flight(e.g origin city, destination)
      if(dataType == FLIGHT_DATE) 
      {
        // uses the format data method from the departure board class to format incorrect dates
        DepartureBoard dateFormatter = new DepartureBoard();
        data = dateFormatter.formatDate(data);
      }
      boolean found = false;
      for (int j = 0;  j < dataList.size();j++) { //itterates through the dataList to ensure there are no duplicates
        String temp = dataList.get(j);
        if (data.equals(temp) && !found) 
        {
          found = true;
          frequency.add(j,1); // if data is already in the dataList, found = true, add 1 to its corresponding place in the frequency array
        }
      }
      if (!found) 
      {  
        dataList.add(data); // if not already in the list, add it
        frequency.append(1);// place the value 1 in the frequency list at the corresponding point
      }
    }                                
    sort(dataList, frequency);
  }
  
    /**A function used to get the data from each flight being analysed based on the current dataType of the graph. 
    * Used within the setData() function frequently
    * History:
    *     old - the same function also set the title for the graph
    *     new - created an individual  void setTitle function which allowed it to be used by other methods without having to return a string.
    */
    public String getData(Flights flight) {
    switch(dataType) {
      case FLIGHT_DATE:
        return flight.getFlightDate();
      case AIRLINE_CODE:
        return flight.getAirlineCode();
      case ORIGIN:
        return flight.getOrigin();
      case ORIGIN_CITY_NAME:
        return flight.getOriginCityName();
      case ORIGIN_STATE:
        return flight.getOriginState();
      case ORIGIN_WAC:
        return String.valueOf(flight.getOriginWac());
      case DESTINATION:
        return flight.getDestination();
      case DEST_CITY_NAME:
        return flight.getDestCityName();
      default:
        return "";
      }
  }

  /* a function that sets the title of the graph depending on the datatype currently being displayed */
  public void setTitle()
  {
      switch(dataType) {
      case FLIGHT_DATE:
        title = "Flight Date";
        break;
      case AIRLINE_CODE:
        title = "Airline Code";
        break;
      case ORIGIN:
        title = "Origin";
        break;
      case ORIGIN_CITY_NAME:
        title = "Origin City";
        break;
      case ORIGIN_STATE:
        title = "Origin State";
        break;
      case ORIGIN_WAC:
        title = "Origin WAC";
        break;
      case DESTINATION:
        title = "Destination";
        break;
      case DEST_CITY_NAME:
        title = "Destination City";
        break;

    }
  }
  
    /** a function that draws the bar chart, drop menu, widgets, and  all the titles and labels.
    * 
    *  History:
    *    Colors
    *      old - colors go from grey to red (Joshua)
    *      new - colors range from blue to red and are scaled based on the size of the list(Can)
    *
    *    Text:
     *      old - large texts did not fit on screen. Text were ill centered. Dates were incorrectly shown
     *      new - texted were centered by calulating a character offset based off size(Lance).
     *            Incorrect dates were formatted using a method from the departure Board class, and longer
     *            names were shortened(Joshua)     
    */

  public void draw() {
    drawWidgets();
    int displayCount = Math.min(MAX_DISPLAY, dataList.size() - startingIndex);
    int actualIndex = 0; // the positioning of each bar( 0 = first bar, 1 = second bar etc);
    image(barChartBackground, 6, 150);
    for (int i = startingIndex; i < startingIndex + displayCount; i++) {
      // Extracting label and count data
      String label = dataList.get(i);  
      int count = frequency.get(i); // get data and corresponding frequency
      
      /* calculate color/size scale */
      float scale = (float) count / frequency.get(0); 
      int redComponent = (int) (scale * 225);
      int blueComponent = 225 - redComponent;
      fill(redComponent, 0, blueComponent); //way in which colour can be expressed based on the value: low (scarce) = blue; high (frequent) = red
      
      // removing alternate names
      if(label.contains("/") && dataType != FLIGHT_DATE)
      {
        int slashIndex = label.indexOf("/");
        label = label.substring(0,slashIndex); // only use the first name begfore the slash
      }

      // Drawing the bar
      rect(xpos, ypos + actualIndex * BAR_HEIGHT, scale*230, 20);
      // Drawing labels
      fill(0);
      int characterOffset;
      if (label.length() > 18) {characterOffset = (label.length() -18)*5+5;} 
      else {characterOffset = 0;}
      
 

      
      text(label, xpos-100-characterOffset, 205 + actualIndex * BAR_HEIGHT);
      text(count, xpos+275, 210 + actualIndex * BAR_HEIGHT);
      text(title, xpos-100, ypos - 30);
      text("Frequency", xpos+275, ypos - 30);

      actualIndex += 1;
    }  
  }
  
  
  /* a function for drawing the widgets*/
  public void drawWidgets()
  {
     dropMenu.draw(); // draws the dropMenu widget
     if(displayDropMenu)   // only draws the other widgets if the dropMenu is being displayed
     {
       /* Draws an down arrow if the Drop Menu is activated*/ 
       line(dropMenu.x + dropMenu.width - 40, dropMenu.y+10,
       dropMenu.x + dropMenu.width - 25, dropMenu.y+30);
       line(dropMenu.x + dropMenu.width - 25, dropMenu.y+30,
       dropMenu.x + dropMenu.width -10, dropMenu.y+10);
       
       for(int i = 0; i < widgetList.length;i++)  // iterates through the widget list
       {
        Widget currentWidget = widgetList[i];
        if(mouseX > currentWidget.x && mouseX < currentWidget.x + currentWidget.width && mouseY > currentWidget.y && mouseY < currentWidget.y +currentWidget.height) 
        { 
        currentWidget.widgetColor = color(200); // if mouse hovers over the widget, the widget turns grey
        }
        else
        {
           currentWidget.widgetColor = widgetColor; // otherwise, the widget color remains as it should be
        }
         // draws each of the widgets in the dropMenu
         currentWidget.y=(dropMenu.y + (i+1)*dropMenu.height );
         currentWidget.draw();
       }  
     } 
     else {
       /* draws a up arrow if drop menu is not being displayed*/
      line(dropMenu.x + dropMenu.width - 40, dropMenu.y+30,
      dropMenu.x + dropMenu.width - 25, dropMenu.y+10);
      line(dropMenu.x + dropMenu.width - 25, dropMenu.y+10,
      dropMenu.x + dropMenu.width -10, dropMenu.y+30);
     }
  }
  
       /** Function that allows the user to scroll through the bar chart. Changes the starting index of the bar chart that is displayed.
       *  History
       *       old - scroll function was just a prototype. User scrolled simply by pressing a button. No way to scroll back,
       *             error if user scrolled too far(Joshua)
       *       new - scroll function called by mouseWheel() function in main. Issues fixed (Adam)
       */
  
  public void scroll(int increment) {
    int maxIndex = Math.max(0, dataList.size() - MAX_DISPLAY); // Maximum starting index to prevent scrolling past the last data
    startingIndex = constrain(startingIndex + increment, 0, maxIndex);
  }
  

  

  /* Function that sorts the frequency list in order descending order, and then orders the corresponding values in the data list */
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

    /** A function that opens the drop menu(or closes it if already open)
    *   Activated by the mouseClicked() function in main.
    *   Onlu opens if the mouse is clicked and the cursor is in the specified boundary
    */
  public void displayWidgets()
  {
    if(mouseX > dropMenu.x && mouseX < dropMenu.x + dropMenu.width && mouseY > dropMenu.y && mouseY < dropMenu.y +dropMenu.height) displayDropMenu = !displayDropMenu;
  }
  
  
    /** function that changes the data being displayed on the bar chart depending on which widget is pressed.
    *   changes the dataType depending on which widget is pressed and calls the setData() function and setTitle() function to update the bar chart
    *   History
    *     old - Function used a mousePressed method to activate each widget, including the drop menu.
    *            Because the mousePressed function occurs continously until the mouse is unpressed,(even if pressed for a seemingly small amount of time)
    *            , it caused to dropMenu to flicker and open and close multiple times.
    *     new - Created a seperate function for displaying the drop menu. Used mouseClicked function in main instead of mousePressed functino(Joshua)
    */
  
  public void widgetEvent()
  {
    for(Widget  widget: widgetList)
     {
        if(displayDropMenu && mouseX > widget.x && mouseX < widget.x + widget.width && mouseY > widget.y && mouseY < widget.y +widget.height)
        {
        dataType = widget.event; 
        setTitle();
        setData(dataType); 
        System.out.print(dataList.size());
      } 
    }
}

}
