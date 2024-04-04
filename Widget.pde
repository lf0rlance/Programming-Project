
class Widget
{
  int x, y, width, height;
  String label; int event;
  color widgetColor, labelColor, lineColor, hoverOverColor;
  PFont widgetFont;
  boolean useFillColor = false;
  String eventString;
  
  Widget(int x, int y, int width, int height, String label, color widgetColor, PFont widgetFont, 
  int event)
  {
    this.x = x; this.y = y; this.width = width; this.height = height;
    this.label = label; this.event = event;
    this.widgetColor = widgetColor; this.widgetFont = widgetFont;
    labelColor = color(0); lineColor = color(0);
  }
  
  Widget(int x, int y, int width, int height, String label, color widgetColor, PFont widgetFont, 
  int event, color hoverOverColor, boolean useFillColor)
  {
    this.x = x; this.y = y; this.width = width; this.height = height;
    this.label = label; this.event = event;
    this.widgetColor = widgetColor; this.widgetFont = widgetFont;
    labelColor = color(0); lineColor = color(0);
    this.hoverOverColor = hoverOverColor;
    this.useFillColor = useFillColor;
  }
  
  Widget(int x, int y, int width, int height, String label, color widgetColor, PFont widgetFont, 
  String event)
  {
    this.x = x; this.y = y; this.width = width; this.height = height;
    this.label = label; this.eventString = event;
    this.widgetColor = widgetColor; this.widgetFont = widgetFont;
    labelColor = color(0); lineColor = color(0);
  }
  
void draw() {
  fill(widgetColor);
  stroke(lineColor);
  rect(x, y, width, height);
  fill(labelColor);
  textAlign(CENTER, CENTER); // Center the text horizontally and vertically
  if(label != null) text(label, x + width/2, y + height/2); // Center the text within the rectangle
}
  
  void mouseOver()
  {
    lineColor = color(255);
    if(useFillColor) widgetColor = hoverOverColor;
  }
  
  void mouseNotOver()
  {
    lineColor = color(0);
    if(useFillColor) widgetColor = color(255);
  }
  
  int getEvent(int mX, int mY)
  {
    if(mX > x && mX < x + width && mY > y && mY < y + height)
    {
      return event;
    }
    return EVENT_NULL;
  }
  
  String getEventString(int mX, int mY)
  {
    if(mX > x && mX < x + width && mY > y && mY < y + height)
    {
      return eventString;
    }
    return null;
  }
}
