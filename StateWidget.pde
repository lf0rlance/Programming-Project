  /** Author: Joshua //<>//
  *  
  *  
  *   Contributers:
  *      Can
  */

class StateWidget 
{
  int x,y;
  PImage image;
  color heatColor;
  String stateCode;
  ArrayList<Flights> flightList;
    int averageLateness;
  
  /** State Widget Constructor Class
  * Creates a  widget that represents a state in the US
  * Paramaters:
  *    @param x,y - coordinates of the state on the map
  *    @param image - the image of the state
  *    @param stateCode - the abbreviated code of the state as appears in the data set
  */
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
      
      if(flight.getDestState().equals(stateCode)) flightList.add(flight); //<>//
    }
    System.out.println(stateCode +": " + flightList.size()); // used for debugging
    heat();
  }
  
  
    /** scaling the colour of the state depending on the average lateness of flights arriving at the state 
    *  states with a relatively high average lateness will be colored red, while states with a low average lateness will be colored blue
    *  history:
    *
    *      lateness calculation
    *       old - lateness calculated simply by substracting scheduled arrival time from actual arrival time 
    *              without taking into account the times were formatted into the data set as a single decimal number
    *              (e.g. 1305 instead of 13:05)
    *       new - better way of calulating latenss by converting time into minutes( Can & Joshua)
    
    *       heat Color
    *        old - colors range from grey to red  depending on lateness
    *        new - colors range from blue to red   (Can)
     
    */     
  public void heat() 
  {
    int totalLateness = 0;

    float redness = 0;
    for(Flights flight:flightList)
    { 
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

    /** Draws each of the states
    *      tints the image of the state depending on 'heat'(lateness)
    *      highlights images that the mouse is over
    *      
    *      History:
    *      old - bug with highlighting function. Inconsistent borders caused multiple states to be highlighted at a time
    *      new - fixed highlighting problem by implementing contains() method making the state highlighted only when the mouse is within the actual image 
    *             and not just its boundaries(Joshua)
    *       
    */    
  public void draw()
  {
    if(mouseOver() && contains(mouseX,mouseY)) tint(#FFFFFF); // highlights the state if the mouse is over(unfinshed: highlights multiple states at a time)
    else tint(heatColor);
    image(image,x,y);
        noTint(); //prevents other images from being affected by tint()
  }
  
  /** Determines if ithe mouse hovers over the state
    *
    *   @return true if mouse is within the image boundaries, false if not
    */    
  public boolean mouseOver(){
    
    if(mouseX > x  && mouseX < x+image.width && mouseY> y && mouseY<y+image.height) return true;
    else return false;
   
    
  }
   
  /** Determines if the state contains the coordinates x,y
    *  @param x,y the coordinate being checked
    *  @return   true if a non transparent part of the state contains the coordinates passed into the parameters.
   */    
  

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
