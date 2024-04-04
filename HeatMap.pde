class HeatMap
{
  
  final int IMAGEX = 100;
  final int IMAGEY = 50;
  Widget flightInfo;  // the tab on the right
  String stateLabel;
  int  lateness;
  StateWidget[] stateWidgets;
  HeatMap()
  {
    stateLabel = "";
   stateWidgets = new StateWidget[51];
   setStateWidgets(); // made it its own method to make the constructor look more tidy
   flightInfo = new Widget(600, 200, 150, 300, "State:\n"+stateLabel + "\n  Avg Lateness:", color(255), stdFont, EVENT_NULL); // should display info on the state being highlighted but its not finished/

  }
  
  public void draw()
  {
   flightInfo.label = "State:\n"+stateLabel + "\n  Avg Lateness:";
   flightInfo.draw();
   for(StateWidget state: stateWidgets)
   {    
     state.draw();
     if(state.mouseOver()) stateLabel = state.stateCode;
     //else stateLabel = "";
   }
  }

  public void setStateWidgets()
  {
    /* Creates a stateWidget object for ever state ,includes Washington DC for no good reason :)  */
     stateWidgets[0] = new StateWidget(155,282,loadImage("Alaska.png"),"AK");
   stateWidgets[1] = new StateWidget(280,312,loadImage("Hawaii.png"),"HI");
   stateWidgets[2] = new StateWidget(143,54,loadImage("Washington.png"),"WA");
   stateWidgets[3] = new StateWidget(145,87,loadImage("Oregon.png"),"OR");
   stateWidgets[4] = new StateWidget(153,145,loadImage("California.png"),"CA");
   stateWidgets[5] = new StateWidget(172,133,loadImage("Nevada.png"),"NV");
   stateWidgets[6] = new StateWidget(194,74,loadImage("Idaho.png"),"ID");
   stateWidgets[7] = new StateWidget(224,64,loadImage("Montana.png"),"MT");
   stateWidgets[8] = new StateWidget(239,96,loadImage("Wyoming.png"),"WY");
   stateWidgets[9] = new StateWidget(291,58,loadImage("North Dakota.png"),"ND");
   stateWidgets[10] = new StateWidget(291,85,loadImage("South Dakota.png"),"SD");
   stateWidgets[11] = new StateWidget(293,111,loadImage("Nebraska.png"),"NE");
   stateWidgets[12] = new StateWidget(253,131,loadImage("Colorado.png"),"CO");
   stateWidgets[13] = new StateWidget(305,136,loadImage("Kansas.png"),"KS");
   stateWidgets[14] = new StateWidget(211,125,loadImage("Utah.png"),"UT");
   stateWidgets[15] = new StateWidget(206,173,loadImage("Arizona.png"),"AZ");
   stateWidgets[16] = new StateWidget(249,173,loadImage("New Mexico.png"),"NM");
   stateWidgets[17] = new StateWidget(290,199,loadImage("Texas.png"),"TX");
   stateWidgets[18] = new StateWidget(301,163,loadImage("Oklahoma.png"),"OK");
   stateWidgets[19] = new StateWidget(345,65,loadImage("Minnesota.png"),"MN");
   stateWidgets[20] = new StateWidget(338,103,loadImage("Iowa.png"),"IA");
   stateWidgets[21] = new StateWidget(343,139,loadImage("Missouri.png"),"MO");
   stateWidgets[22] = new StateWidget(348,170,loadImage("Arkansas.png"),"AR");
   stateWidgets[23] = new StateWidget(353,202,loadImage("Louisiana.png"),"LA");
   stateWidgets[24] = new StateWidget(389,78,loadImage("Michigan.png"),"MI");
   stateWidgets[25] = new StateWidget(367,80,loadImage("Wisconsin.png"),"WI");
   stateWidgets[26] = new StateWidget(370,126,loadImage("Illinois.png"),"IL");
   stateWidgets[27] = new StateWidget(395,141,loadImage("Kentucky.png"),"KY");
   stateWidgets[28] = new StateWidget(387,160,loadImage("Tennessee.png"),"TN");
   stateWidgets[29] = new StateWidget(364,185,loadImage("Missisippi.png"),"MS");
   stateWidgets[30] = new StateWidget(390,185,loadImage("Alabama.png"),"AL");
   stateWidgets[31] = new StateWidget(412,228,loadImage("Florida.png"),"HI");
   stateWidgets[32] = new StateWidget(415,185,loadImage("Georgia.png"),"GA");
   stateWidgets[33] = new StateWidget(430,178,loadImage("South Carolina.png"),"SC");
   stateWidgets[34] = new StateWidget(434,166,loadImage("North Carolina.png"),"NC");
   stateWidgets[35] = new StateWidget(441,141,loadImage("Virginia.png"),"VA");
   stateWidgets[36] = new StateWidget(431,134,loadImage("West Virginia.png"),"WV");
   stateWidgets[37] = new StateWidget(390,125,loadImage("Indiana.png"),"IN");
   stateWidgets[38] = new StateWidget(418,118,loadImage("Ohio.png"),"OH");
   stateWidgets[39] = new StateWidget(453,110,loadImage("Pennsylvania.png"),"PA");
   stateWidgets[40] = new StateWidget(466,96,loadImage("New York.png"),"NY");
   stateWidgets[41] = new StateWidget(516,75,loadImage("Maine.png"),"ME");
   stateWidgets[42] = new StateWidget(493,86,loadImage("Vermont.png"),"VT");
   stateWidgets[43] = new StateWidget(499,86,loadImage("New Hampshire.png"),"NH");
   stateWidgets[44] = new StateWidget(501,100,loadImage("Massachussetts.png"),"MA");
   stateWidgets[45] = new StateWidget(488,103,loadImage("Rhode Island.png"),"RI");
   stateWidgets[46] = new StateWidget(498,102,loadImage("Connecticut.png"),"CT");
   stateWidgets[47] = new StateWidget(473,119,loadImage("New Jersey.png"),"NJ");
   stateWidgets[48] = new StateWidget(468,128,loadImage("Delaware.png"),"Delaware");
   stateWidgets[49] = new StateWidget(454,131,loadImage("Maryland.png"),"MD");
   stateWidgets[50] = new StateWidget(455,132,loadImage("Washington DC.png"),"DC");
   
   
  }
  
  
  PVector getRandomStatePosition() {
    // Get a random state widget's position
    int index = int(random(stateWidgets.length));
    StateWidget randomState = stateWidgets[index];
    
    // Calculate the boundaries for x and y closer to the center of the image
    int minX = randomState.x + randomState.image.width / 3; // Adjust as needed
    int maxX = randomState.x + 2 * randomState.image.width / 3; // Adjust as needed
    int minY = randomState.y + randomState.image.height / 3; // Adjust as needed
    int maxY = randomState.y + 2 * randomState.image.height / 3; // Adjust as needed
    
    // Generate random coordinates within the closer-to-center area of the image
    int x = int(random(minX, maxX));
    int y = int(random(minY, maxY));
    
     return new PVector(x, y);

  }
  
}
