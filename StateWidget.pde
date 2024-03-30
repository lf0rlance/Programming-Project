class StateWidget
{
  int x,y;
  PImage image;
  color heatColor;
  String stateCode;
  ArrayList<Flights> flightList;
  int totalDelay;
  
  
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
    int redness = 0;
    int blueness = 50;
    for(Flights flight:flightList)
    {
      totalDelay += flight.getDepTime() - flight.getCrsDepTime();
      redness += totalDelay*20;
      blueness -= totalDelay*20;
      
      
    }
    heatColor = color(redness,0,blueness);
  }
  
  public void draw()
  {
    if(mouseOver()) tint(#FFFFFF); // highlights the state if the mouse is over(unfinshed: highlights multiple states at a time)
    else tint(heatColor);
    image(image,x,y+20);
    noTint();
  }
  
  public boolean mouseOver(){
    
    if(mouseX > x  && mouseX < x+image.width && mouseY> y && mouseY<y+image.height) return true;
    else return false;
   
    
  }
  
  
  
}
