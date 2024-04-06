class StateWidget //<>//
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

    int redness = 0;
    //int blueness = 255;
    for(Flights flight:flightList)
    { 
      //New improved way of calculating lateness
      //int arrival = (flight.getArrTime()/100) + (flight.getArrTime()%100);
      //int actualArrival = (flight.getCrsArrTime()/100) + (flight.getCrsArrTime()%100);
      
      // if(arrival >= actualArrival) totalLateness += (arrival - actualArrival);
      //else totalLateness -= (arrival - actualArrival);
      
      if(flight.getArrTime() >= flight.getCrsArrTime()) totalLateness += (flight.getArrTime() - flight.getCrsArrTime());
      else totalLateness -= (flight.getArrTime() - flight.getCrsArrTime());
    }
    if(flightList.size() >0)
    {
    averageLateness = totalLateness/ flightList.size();
    System.out.println("Average Lateness: "+ averageLateness);
    //
    redness += averageLateness;
    //blueness -= averageLateness;
    }
    heatColor = color(redness,0,0);
    
  } //<>//
  
  public void draw()
  {
    if(mouseOver())
    {
      tint(#FFFFFF); // highlights the state if the mouse is over(unfinshed: highlights multiple states at a time)
    }
    else 
    {
      tint(heatColor);
    }
    image(image,x,y);
    noTint(); //prevents other images from being affected by tint()
  }
  
  public boolean mouseOver(){
    
    if(mouseX > x  && mouseX < x+ image.width && mouseY> y  && mouseY<y+image.height   ) //&& (get(mouseX,mouseY) == heatColor || get(mouseX,mouseY) ==  #FFFFFF )
    {
       
     // if(get(mouseX,mouseY) == heatColor ||  get(mouseX,mouseY) == (#FFFFFF)) 
      return true;
    }
     return false;
  }
  
  
}
