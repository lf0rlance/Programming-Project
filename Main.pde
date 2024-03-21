// main class
Flights allFlightData[];
ArrayList<String> originData;
IntList originDataCount;

BarChart originBarChart;


Screen currentScreen, screen1, screen2;
PFont stdFont;
final int EVENT_NULL = 0;
final int EVENT_BUTTON1 = 1; final int EVENT_FORWARD = 2;
final int EVENT_BUTTON2 = 3; final int EVENT_BACKWARD = 4;

void settings()
{
  size(500, 500); 
}
public void setup() 
{
  //reading data from file and organising into object array for useage ************************
  ArrayList<String> rawDataInArrayForm = new ArrayList<String>();
  try 
    {
      BufferedReader flights = createReader("flights2k.csv");
      String currentLine;
      int i = 0;
      while((currentLine = flights.readLine()) != null)
      {
        if(i != 0)
        {
          rawDataInArrayForm.add(currentLine);
        }
        i++;
      }
      flights.close();
    }
    catch(Exception e)
    {
      System.out.println("Error at DataLoader Class constructor");
    }
    allFlightData = new Flights[rawDataInArrayForm.size()];
   for(int i = 0; i < rawDataInArrayForm.size(); i++)
   {
     allFlightData[i] = new Flights(rawDataInArrayForm.get(i));
   }
  //*******************************************************************************************
  
  //placeholder code for screen/widget
  Widget widget1, widget2, widget3, widget4;
  stdFont = loadFont("AgencyFB-Bold-30.vlw");
  textFont(stdFont);
  widget1 = new Widget(100, 100, 180, 40, "Button 1", color(200, 0, 0), stdFont, EVENT_BUTTON1);
  widget2 = new Widget(100, 200, 180, 40, "Forward", color(0, 200, 0), stdFont, EVENT_FORWARD);
  widget3 = new Widget(100, 100, 180, 40, "scroll", color(0, 0, 200), stdFont, EVENT_BUTTON2);
  widget4 = new Widget(100, 200, 180, 40, "Backward", color(0, 200, 200), stdFont, EVENT_BACKWARD);
  screen1 = new Screen(color(255));
  screen2 = new Screen(color(150));
  screen1.add(widget1);
  screen1.add(widget2);
  screen2.add(widget3);
  screen2.add(widget4);
  currentScreen = screen1;
  
  originBarChart = new BarChart(200,280,5);
  


    
    
  
  
  
  
}

public void draw() 
{
  currentScreen.draw();
  if(currentScreen.getEvent(mouseX, mouseY) == EVENT_BUTTON1) 
  {
    Widget temp = (Widget) currentScreen.getWidgets().get(0);
    temp.mouseOver();
  }
  else if(currentScreen.getEvent(mouseX, mouseY) == EVENT_BUTTON2) 
  {
    Widget temp = (Widget) currentScreen.getWidgets().get(0);
    temp.mouseOver();
  }
  else if(currentScreen.getEvent(mouseX, mouseY) == EVENT_FORWARD) 
  {
    Widget temp = (Widget) currentScreen.getWidgets().get(1);
    temp.mouseOver();
  }
  else if(currentScreen.getEvent(mouseX, mouseY) == EVENT_BACKWARD) 
  {
    Widget temp = (Widget) currentScreen.getWidgets().get(1);
    temp.mouseOver();
  }
  else 
  {
    Widget temp = (Widget) currentScreen.getWidgets().get(0);
    temp.mouseNotOver();
    temp = (Widget) currentScreen.getWidgets().get(1);
    temp.mouseNotOver();
  }
  

  if(currentScreen == screen2)
  {
    originBarChart.draw();
  }
    
  
  
  

  
  
  
  
}

public void mousePressed() 
{
  switch(currentScreen.getEvent(mouseX, mouseY))
  {
    case EVENT_BUTTON1:
      println("button 1!");
      
      break;
    case EVENT_BUTTON2:
      originBarChart.scroll();
      println("button2!");
      break;
    case EVENT_FORWARD:
      println("forward"); currentScreen = screen2;
      break;
    case EVENT_BACKWARD:
      println("backward"); currentScreen = screen1;
      break;
  }
}

// Other parts of the program
