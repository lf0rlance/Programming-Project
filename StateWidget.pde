class StateWidget //<>// //<>//
{
  int x,y;
  PImage image;
  color heatColor;
  String stateCode;
  ArrayList<Flights> flightList;
    int averageLateness;
  
  
  StateWidget(int x,int y,PImage image, String stateCode)
  {
    
    this.x = x;
    this.y = y;
    this.image = image;
    this.stateCode = stateCode;
    
    flightList = new ArrayList<Flights>();
    heatColor = color(0,0,100);
  
    for(Flights flight: allFlightData)
    {
      
      if(flight.getDestState().equals(stateCode)) flightList.add(flight);
    }
    System.out.println(stateCode +": " + flightList.size());
    heat();
  }
  
  
  public void heat() // chaging the 'heat' depending on the lateness. Maybe adjust so it uses average lateness? Color changing needs to be improved.
  {
    int totalLateness = 0;

    float redness = 0;
    //int blueness = 255;
    for(Flights flight:flightList)
    {
      // old way of calculating lateness( good colors but incorrect data)
      if(flight.getArrTime() >= flight.getCrsArrTime()) totalLateness += (flight.getArrTime() - flight.getCrsArrTime()); //<>// //<>//
      else totalLateness -= (flight.getArrTime() - flight.getCrsArrTime());
      
       //New improved way of calculating lateness
     // int arrival = (flight.getArrTime()/100) + (flight.getArrTime()%100);
   //   int actualArrival = (flight.getCrsArrTime()/100) + (flight.getCrsArrTime()%100);
      
     // if(arrival >= actualArrival) totalLateness += (arrival - actualArrival);
   //   else totalLateness -= (arrival - actualArrival);
      
 
    }
    
    
    if(flightList.size() >0)
    {
    averageLateness = totalLateness/ flightList.size();
    System.out.println("Average Lateness: "+ averageLateness);
    //
    redness += averageLateness;
    redness = redness/320.0;
    }
    heatColor = color(redness*225,0,260-(redness*225));
    
  }
  
  public void draw()
  {
    if(mouseOver() && contains(mouseX,mouseY)) tint(#FFFFFF); // highlights the state if the mouse is over(unfinshed: highlights multiple states at a time)
    else tint(heatColor);
    image(image,x,y);
        noTint(); //prevents other images from being affected by tint()
  }
  
  public boolean mouseOver(){
    
    if(mouseX > x  && mouseX < x+image.width && mouseY> y && mouseY<y+image.height) return true;
    else return false;
   
    
  }
  
  
    boolean contains(int nx, int ny)
  {
    
    if(mouseOver())
    {
      int imgX = nx - x;
      int imgY = ny - y;
        
     // Get the color of the pixel at (x, y)
     int loc = imgX + imgY * image.width;
     
     color pixelColor = image.pixels[loc]; // the color of the pixel at 
     if( alpha(pixelColor) > 0) // if the x,y coordinate is at a non transparent part of the image(if the mouse is within the actual state)
     {
       return true;
     }
      
    }
    
    return false;
  }
  
  
  
}
