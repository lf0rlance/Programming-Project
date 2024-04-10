class HeatMap
{
  PImage border;
  int xpos, ypos,  lateness;
  
  Widget flightInfo;  // the tab on the right
  
  String stateLabel;
  boolean stateHighlighted = false;
 
  StateWidget[] stateWidgets;
  HeatMap(int xpos, int ypos)
  {
    this.xpos = xpos;
    this.ypos = ypos;
    border = loadImage("Border.png");
    stateLabel = "";
   stateWidgets = new StateWidget[51];
   setStateWidgets(); // made it its own method to make the constructor look more tidy
   flightInfo = new Widget(600, 200, 150, 300, "State:\n"+stateLabel + "\n  Avg Lateness:", color(255), stdFont, EVENT_NULL);
  
  }
  
  // function that draws each of the statesWudgets, and updates the info on the flight info tab when the mouse hovers over it 
  public void draw()
  {
   image(border,xpos,ypos);
   image(legendMap, 10, 65);
 
   for(StateWidget state: stateWidgets)
   {    
     state.draw();
     if(state.mouseOver() && state.contains(mouseX,mouseY) )
     {
       stateLabel = state.stateCode;
       lateness = state.averageLateness;
       stateHighlighted = true;
     }
   }
   flightInfo.label = "State:\n"+stateLabel + "\n  Avg Lateness:\n" + lateness + " mins";
   flightInfo.draw();
  }
  


  public void setStateWidgets()
  {
    /* Creates a stateWidget object for every state ,(includes Washington DC)  */

   stateWidgets[0] = new StateWidget(xpos + 5, ypos + 182,loadImage("Alaska.png"),"AK");
   stateWidgets[1] = new StateWidget(xpos + 238, ypos + 278,loadImage("Hawaii.png"),"HI");
   stateWidgets[2] = new StateWidget(xpos +43,ypos + 4,loadImage("Washington.png"),"WA");
   stateWidgets[3] = new StateWidget(xpos + 47, ypos + 40,loadImage("Oregon.png"),"OR");
   stateWidgets[4] = new StateWidget(xpos + 52, ypos + 70,loadImage("California.png"),"CA");
   stateWidgets[5] = new StateWidget(xpos + 78, ypos + 69,loadImage("Nevada.png"),"NV");
   stateWidgets[6] = new StateWidget(xpos + 105, ypos + 13,loadImage("Idaho.png"),"ID");
   stateWidgets[7] = new StateWidget(xpos+112, ypos + 12,loadImage("Montana.png"),"MT");
   stateWidgets[8] = new StateWidget(xpos + 144, ypos + 45,loadImage("Wyoming.png"),"WY");
   stateWidgets[9] = new StateWidget(xpos + 195,ypos + 12,loadImage("North Dakota.png"),"ND");
   stateWidgets[10] = new StateWidget(xpos + 195,ypos + 38,loadImage("South Dakota.png"),"SD");
   stateWidgets[11] = new StateWidget(xpos + 195,ypos + 64,loadImage("Nebraska.png"),"NE");
   stateWidgets[12] = new StateWidget(xpos + 157,ypos + 83,loadImage("Colorado.png"),"CO");
   stateWidgets[13] = new StateWidget(xpos + 208,ypos + 89,loadImage("Kansas.png"),"KS");
   stateWidgets[14] = new StateWidget(xpos + 124,ypos + 68,loadImage("Utah.png"),"UT");
   stateWidgets[15] = new StateWidget(xpos + 118,ypos + 114,loadImage("Arizona.png"),"AZ");
   stateWidgets[16] = new StateWidget(xpos + 157, ypos + 115,loadImage("New Mexico.png"),"NM");
   stateWidgets[17] = new StateWidget(xpos + 174,ypos + 117,loadImage("Texas.png"),"TX");
   stateWidgets[18] = new StateWidget(xpos + 201,ypos + 113,loadImage("Oklahoma.png"),"OK");
   stateWidgets[19] = new StateWidget(xpos + 247,ypos + 7,loadImage("Minnesota.png"),"MN");
   stateWidgets[20] = new StateWidget(xpos + 246, ypos + 57,loadImage("Iowa.png"),"IA");
   stateWidgets[21] = new StateWidget(xpos + 247,ypos + 80,loadImage("Missouri.png"),"MO");
   stateWidgets[22] = new StateWidget(xpos + 259,ypos + 120,loadImage("Arkansas.png"),"AR");
   stateWidgets[23] = new StateWidget(xpos + 265,ypos + 152,loadImage("Louisiana.png"),"LA");
   stateWidgets[24] = new StateWidget(xpos + 289,ypos + 15,loadImage("Michigan.png"),"MI");
   stateWidgets[25] = new StateWidget(xpos + 270,ypos + 25,loadImage("Wisconsin.png"),"WI");
   stateWidgets[26] = new StateWidget(xpos + 285,ypos + 70,loadImage("Illinois.png"),"IL");
   stateWidgets[27] = new StateWidget(xpos + 298,ypos + 97,loadImage("Kentucky.png"),"KY");
   stateWidgets[28] = new StateWidget(xpos + 292, ypos + 120,loadImage("Tennessee.png"),"TN");
   stateWidgets[29] = new StateWidget(xpos + 278,ypos +  132,loadImage("Missisippi.png"),"MS");
   stateWidgets[30] = new StateWidget(xpos + 305,ypos + 134,loadImage("Alabama.png"),"AL");
   stateWidgets[31] = new StateWidget(xpos + 309,ypos + 162,loadImage("Florida.png"),"FL");
   stateWidgets[32] = new StateWidget(xpos + 323,ypos + 133,loadImage("Georgia.png"),"GA");
   stateWidgets[33] = new StateWidget(xpos + 342,ypos + 132,loadImage("South Carolina.png"),"SC");
   stateWidgets[34] = new StateWidget(xpos + 336,ypos + 120,loadImage("North Carolina.png"),"NC");
   stateWidgets[35] = new StateWidget(xpos + 343, ypos + 95,loadImage("Virginia.png"),"VA");
   stateWidgets[36] = new StateWidget(xpos + 346,ypos + 88,loadImage("West Virginia.png"),"WV");
   stateWidgets[37] = new StateWidget(xpos + 309,ypos + 76,loadImage("Indiana.png"),"IN");
   stateWidgets[38] = new StateWidget(xpos + 329,ypos + 70,loadImage("Ohio.png"),"OH");
   stateWidgets[39] = new StateWidget(xpos + 361,ypos + 66,loadImage("Pennsylvania.png"),"PA");
   stateWidgets[40] = new StateWidget(xpos + 368,ypos + 45,loadImage("New York.png"),"NY");
   stateWidgets[41] = new StateWidget(xpos + 428,ypos + 26,loadImage("Maine.png"),"ME");
   stateWidgets[42] = new StateWidget(xpos + 413, ypos + 44,loadImage("Vermont.png"),"VT");
   stateWidgets[43] = new StateWidget(xpos + 420,ypos + 45,loadImage("New Hampshire.png"),"NH");
   stateWidgets[44] = new StateWidget(xpos + 412,ypos + 63,loadImage("Massachussetts.png"),"MA");
   stateWidgets[45] = new StateWidget(xpos + 424,ypos + 70,loadImage("Rhode Island.png"),"RI");
   stateWidgets[46] = new StateWidget(xpos + 413,ypos + 70,loadImage("Connecticut.png"),"CT");
   stateWidgets[47] = new StateWidget(xpos + 396,ypos + 76,loadImage("New Jersey.png"),"NJ");
   stateWidgets[48] = new StateWidget(xpos + 394, ypos + 89,loadImage("Delaware.png"),"DE");
   stateWidgets[49] = new StateWidget(xpos + 368,ypos + 90,loadImage("Maryland.png"),"MD");
   stateWidgets[50] = new StateWidget(xpos + 380,ypos + 98,loadImage("Washington DC.png"),"DC");
   
  }
  
  
  
  
  
  
}
