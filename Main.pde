// main class
Flights allFlightData[];
Screen currentScreen, menuScreen, airportScreen, dateScreen, latenessScreen, graphsScreen;
PFont stdFont;
final int EVENT_NULL = 0;
final int AIRPORT_LOCATOR_BUTTON = 1;
final int DATE_BUTTON = 2;
final int LATENESS_BUTTON = 3;
final int GRAPHS_BUTTON = 4;
ArrayList<String> originData;
IntList originDataCount;
BarChart originBarChart;
PImage cloudImage;
PImage programName;

void settings() {
  size(800, 550);
}

public void setup() {
    // Load the cloud image here
  cloudImage = loadImage("cloud.jpg");
  programName = loadImage("programName.png");
  //reading data from file and organising into object array for usage ************************
  ArrayList<String> rawDataInArrayForm = new ArrayList<String>();
  try {
    BufferedReader flights = createReader("flights_full.csv");
    String currentLine;
    int i = 0;
    while ((currentLine = flights.readLine()) != null) {
      if (i != 0) {
        rawDataInArrayForm.add(currentLine);
      }
      i++;
    }
    flights.close();
  } catch (Exception e) {
    System.out.println("Error at DataLoader Class constructor");
  }
  allFlightData = new Flights[rawDataInArrayForm.size()];
  for (int i = 0; i < rawDataInArrayForm.size(); i++) {
    allFlightData[i] = new Flights(rawDataInArrayForm.get(i));
  }
  //*******************************************************************************************

  //placeholder code for screen/widget
  Widget widget1, widget2, widget3, widget4;
  stdFont = loadFont("AgencyFB-Bold-30.vlw");
  textFont(stdFont);
  int menuWidth = 300; // Width of each menu widget
  int menuX = (width - menuWidth) / 2; // Centering the menu horizontally

  // Adjusted positions and labels based on the order you specified
  widget1 = new Widget(menuX, 225, menuWidth, 40, "Airport Locator", color(255), stdFont, AIRPORT_LOCATOR_BUTTON);
  widget2 = new Widget(menuX, 275, menuWidth, 40, "Date", color(255), stdFont, DATE_BUTTON);
  widget3 = new Widget(menuX, 325, menuWidth, 40, "Lateness", color(255), stdFont, LATENESS_BUTTON);
  widget4 = new Widget(menuX, 375, menuWidth, 40, "Graphs", color(255), stdFont, GRAPHS_BUTTON);
  menuScreen = new Screen(color(80, 200, 242));
  menuScreen.add(widget1);
  menuScreen.add(widget2);
  menuScreen.add(widget3);
  menuScreen.add(widget4);
  
  // Create screens for each functionality
  airportScreen = new Screen(color(255));
  airportScreen.add(new Widget(width - 550, height - 525, 300, 40, "Airport Locator Screen", color(168,213,229), stdFont, EVENT_NULL));
  
  dateScreen = new Screen(color(255));
  dateScreen.add(new Widget(width - 550, height - 525, 300, 40, "Date Screen", color(168,213,229), stdFont, EVENT_NULL));
  
  latenessScreen = new Screen(color(255));
  latenessScreen.add(new Widget(width - 550, height - 525, 300, 40, "Lateness Screen", color(168,213,229), stdFont, EVENT_NULL));
  
  graphsScreen = new Screen(color(255));
  graphsScreen.add(new Widget(width - 550, height - 525, 300, 40, "Graphs Screen", color(168,213,229), stdFont, EVENT_NULL));
  
  currentScreen = menuScreen;
  originBarChart = new BarChart(325,200,5);
}

public void draw() {
  // Draw the background first
  background(currentScreen.screenColor);
  
  // Draw the cloud background only if the current screen is the menu screen (screen1)
  if (currentScreen == menuScreen) {
    currentScreen.updateCloudPosition();
    image(cloudImage, currentScreen.getCloudX(), 0); // Draw the cloud at its current position
    image(cloudImage, currentScreen.getCloudX() - width, 0); // Draw another cloud to the left for wrapping
    image(programName, 225, 140);
  }
  
  // Draw the widgets
  for (int i = 0; i < currentScreen.getWidgets().size(); i++) {
    Widget temp = (Widget) currentScreen.getWidgets().get(i);
    temp.draw(); // Draw each widget
  }
  
  // Check for mouse interaction and update widget appearance
  currentScreen.overWidgetCheck(currentScreen);
  if (currentScreen != menuScreen) {
    currentScreen.drawBackButton(); // Draw the back button only if not on the menu screen
  }
  
  // Draw specific elements based on the current screen
  if(currentScreen == graphsScreen) {
    originBarChart.draw();
  }
}

public void mousePressed() {
  int event = currentScreen.getEvent(mouseX, mouseY);
  if (event != EVENT_NULL) {
    println("Button clicked: " + event);
    // Here you can handle each button click event
    switch (event) {
      case AIRPORT_LOCATOR_BUTTON:
        currentScreen = airportScreen; // Navigate to Airport Locator screen
        break;
      case DATE_BUTTON:
        currentScreen = dateScreen; // Navigate to Date screen
        break;
      case LATENESS_BUTTON:
        currentScreen = latenessScreen; // Navigate to Lateness screen
        break;
      case GRAPHS_BUTTON:
        currentScreen = graphsScreen; // Navigate to Graphs screen
        break;
    }
  }
}

void mouseWheel(MouseEvent event) {
  int increment = event.getCount();     // Fixed reverse scroll
  if (currentScreen == graphsScreen) {
    originBarChart.scroll(increment);
  }
}
