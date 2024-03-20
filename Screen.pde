class Screen
{
  ArrayList screenWidgets;
  color screenColor;
  
  public Screen(color screenColor)
  {
    screenWidgets = new ArrayList();
    this.screenColor = screenColor;
  }
  
  public void add(Widget theWidget)
  {
    screenWidgets.add(theWidget);
  }
  
  void draw()
  {
    background(screenColor);
    for(int i = 0; i < screenWidgets.size(); i++)
    {
      Widget aWidget = (Widget) screenWidgets.get(i);
      aWidget.draw();
    }
  }
  
  public int getEvent(int mX, int mY)
  {
    for(int i = 0; i < screenWidgets.size(); i++)
    {
      Widget aWidget = (Widget) screenWidgets.get(i);
      int event = aWidget.getEvent(mX, mY);
      if(event != EVENT_NULL) return event;
    }
    return EVENT_NULL;
  }
  
  public ArrayList getWidgets()
  {
    return screenWidgets; 
  }
}
