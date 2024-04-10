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
    System.out.println(stateCode +": " + flightList.size()); // used for debugging
    heat();
  }
  
  // scaling the colour of the state depending on the average lateness of flights in the zone
  public void heat() 
  {
    int totalLateness = 0;

    float redness = 0;
    for(Flights flight:flightList)
    { //<>//
       //New improved way of calculating lateness
      int arrival = (flight.getArrTime()/100*60) + (flight.getArrTime()%100); // converts time into minutes
      int actualArrival = (flight.getCrsArrTime()/100*60) + (flight.getCrsArrTime()%100); 
      
      if(arrival >= actualArrival) totalLateness += (arrival - actualArrival); // if the flight is late, add the amount to total lateness
      
      
 
    }
    if(flightList.size() >0)
    {
    averageLateness = totalLateness/ flightList.size();
    System.out.println("Average Lateness: "+ averageLateness);

    redness += averageLateness ;
    redness /= 30;

    }
    heatColor = color(redness*225,0,260-(redness*225)); //way in which colour can be expressed based on the value: low (punctual) = blue (cold); high (late) = red (hot)
  }

  // draws the states
  public void draw()
  {
    if(mouseOver() && contains(mouseX,mouseY)) tint(#FFFFFF); // highlights the state if the mouse is over(unfinshed: highlights multiple states at a time)
    else tint(heatColor);
    image(image,x,y);
        noTint(); //prevents other images from being affected by tint()
  }
  // determines if ithe mouse hovers over the state
  public boolean mouseOver(){
    
    if(mouseX > x  && mouseX < x+image.width && mouseY> y && mouseY<y+image.height) return true;
    else return false;
   
    
  }
  
  // Determines if the state contains the coordinates x,y
  // only returns true if a non transparent part of the state contains the coordinates passed into the parameters.
 // used to prevent multiple states from highlighting at the same time(due to overlapping boundaries but not overlapping images) in the draw function

   boolean contains(int x, int y )
  {
    if(mouseOver())
    {
      int pixelX = x - this.x;
      int pixelY = y - this.y;
     // Get the color of the pixel at (x, y)
     int loc = pixelX + pixelY * image.width;
     color pixelColor = image.pixels[loc]; // the color of the pixel at  x,y
     if( alpha(pixelColor) > 0) // if the x,y coordinate is at a non transparent part of the image(if the mouse is within the actual state)
     {
       return true;
     }  
    }
    return false;
  }
  
  
  
}
