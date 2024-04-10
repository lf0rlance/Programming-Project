//Author: Lance
class Calender //class that makes a clickable array of calender dates 
{
  Screen currentScreen;
  PFont theFont;
  
  Calender(Screen currentScreen, PFont theFont) //takes in screen (date screen) and makes the calender
  {
    this.theFont = theFont;
    this.currentScreen = currentScreen;
    for(int a = 120; a < 687; a += 81)  //index is used to get coorordinates
    {
      String weekDay = "";
      if(a == 120) weekDay = "Sun";
      else if(a == 201) weekDay = "Mon";
      else if(a == 282) weekDay = "Tue";
      else if(a == 363) weekDay = "Wed";
      else if(a == 444) weekDay = "Thu";
      else if(a == 525) weekDay = "Fri";
      else if(a == 606) weekDay = "Sat";
      this.currentScreen.add(new Widget(a, 90, 80, 35, weekDay, color(168,213,229), theFont, EVENT_NULL));
    }
    for(int i = 126; i < 432; i += 51)  //y coorordinate index
    {
      for(int j = 120; j < 687; j+= 81)  //x coorordinate index
      {
        String date = "";
        if((((((i - 125) / 50) * 7) + ((j - 120) / 80)) - 5) <= 0 || (((((i - 125) / 50) * 7) + ((j - 120) / 80)) - 5) > 31) //ignores empty slots in calender
        {
          date = "";
          Widget tempWidget = new Widget(j, i, 80, 50, date, color(255), theFont,  EVENT_NULL);
          this.currentScreen.add(tempWidget);
        }
        else 
        {
          date += (((((i - 125) / 50) * 7) + ((j - 120) / 80)) - 5); //converts y and x indexs to the calender date
          Widget tempWidget = new Widget(j, i, 80, 50, date, color(255), theFont,  (((((i - 125) / 50) * 7) + ((j - 120) / 80)) - 5), color(168, 213, 229), true);
          this.currentScreen.add(tempWidget);
        }
      }
    }
  }
  
  void draw()
  {
    for (Widget temp : currentScreen.getWidgets()) 
    {
      temp.draw(); // Draw each widget
    }
  }
  
  public Screen mousePressed(Screen currentScreen, Flights data[]) //Returns Relevent Screen with relevant data for date pressed
  {
    int event = currentScreen.getEvent(mouseX, mouseY); //gets event associated with a date widget
    if (event != EVENT_NULL) 
    {
      println("Button clicked CALENDAR: " + event);
      if (event >= 1 && event <= 31) 
      {
        //data to calculate
        int numOfFlights = 0;
        float percentOfLateDepartFlights = 0;
        float percentOfLateArrFlights = 0;
        int numOfCancelledFlights = 0;
        int averageFlightDistance = 0;
        int i = 0;
        boolean quickDataExtract = true;
        calendarCloud = loadImage("calendarCloud.png");
        while(quickDataExtract && i != 563737) //retriving data
        {
          int numTempDate;
          char tempDate = data[i].getFlightDate().charAt(2);
          if(data[i].getFlightDate().charAt(3) != '/') //gets date from data and sees if it has two digits
          {
            numTempDate = Character.getNumericValue(tempDate);
            numTempDate *= 10;
            numTempDate += Character.getNumericValue(data[i].getFlightDate().charAt(3));
          }
          else numTempDate = Character.getNumericValue(tempDate); //convert extracted date to int
          if(numTempDate != event && numOfFlights != 0) quickDataExtract = false;
          else if(numTempDate == event) //if date matches increment relevent data
          {
            numOfFlights++;
            if(data[i].getDepTime() - data[i].getCrsDepTime() > 20 || data[i].getCrsDepTime() - data[i].getDepTime() > 20) percentOfLateDepartFlights++;
            if(data[i].getArrTime() - data[i].getCrsArrTime() > 20 || data[i].getCrsArrTime() - data[i].getArrTime() > 20) percentOfLateArrFlights++;
            if(data[i].getCancelled() == 1) numOfCancelledFlights++;
            averageFlightDistance += data[i].getDistance();
          }
          i++;
        }
        percentOfLateDepartFlights = (percentOfLateDepartFlights / numOfFlights) * 100;
        percentOfLateArrFlights = (percentOfLateArrFlights / numOfFlights) * 100;
        averageFlightDistance = averageFlightDistance / numOfFlights;
        //add the final calculated data to the right screen
        dateDataScreen.add(new Widget(200, 25, 400, 50, "Flight Information " + event + "/01/2022", color(255), theFont, EVENT_NULL));
        dateDataScreen.add(new Widget(100, 150, 600, 50, "Amount of flights: " + numOfFlights, color(255), theFont, EVENT_NULL));
        dateDataScreen.add(new Widget(100, 200, 600, 50, "Percent of flights departed late: " + (int) percentOfLateDepartFlights + "%", color(255), theFont, EVENT_NULL));
        dateDataScreen.add(new Widget(100, 250, 600, 50, "Percent of flights arrived late: " + (int) percentOfLateArrFlights + "%", color(255), theFont, EVENT_NULL));
        dateDataScreen.add(new Widget(100, 300, 600, 50, "Amount of cancelled flights: " + numOfCancelledFlights, color(255), theFont, EVENT_NULL));
        dateDataScreen.add(new Widget(100, 350, 600, 50, "Average flight distance: " + averageFlightDistance + " miles", color(255), theFont, EVENT_NULL));
        return dateDataScreen; 
      }
      else
      {
        return currentScreen;
      }
    }
    return currentScreen;
  }
  
}
