class Calender
{
  PImage calender;
  Screen currentScreen;
  int cases;
  
  Calender(PImage calender, Screen currentScreen)
  {
    cases = 0;
    this.calender = calender;
    this.currentScreen = currentScreen;
    for(int i = 126; i < 444; i+= 53)
    {
      for(int j = 100; j < 695; j+= 85)
      {
        if((j >= 100 && j < 610 && i >= 126 && i < 179) || 
        (j >= 270 && j <= 695 && i >= 391 && i <= 444)) { }
        else
        {
          Widget tempWidget = new Widget(j, i, 85, 53, 
          (((((i - 126) / 53) * 7) + ((j - 100) / 85)) - 5));
          this.currentScreen.add(tempWidget);
        }
      }
    }
  }
  
  void draw()
  {
    if(cases == 0) 
    {
      image(calender, 100, 100);
 //     for (Widget temp : currentScreen.getWidgets()) 
   //   {
     //   temp.draw(); // Draw each widget
  //    }
    }
  }
  
  public void mouseClicked()
  {
    int event = currentScreen.getEvent(mouseX, mouseY);
    if(event != EVENT_NULL) 
    {
      println("Button clickedCALENDER: " + event);
      // Here you can handle each button click event
      switch (event) 
      {
        case 1:
          currentScreen = new Screen(color(334));
          cases = 1;
          break;
        case 2:
          currentScreen = dateScreen; // Navigate to Date screen
          break;
        case 3:
          currentScreen = latenessScreen; // Navigate to Lateness screen
          break;
        case 4:
          currentScreen = graphsScreen; // Navigate to Graphs screen
          break;
      }
    }
  }
  
}

//85 width,, 26 height gap,,  53 height
