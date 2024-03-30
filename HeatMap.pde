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
  }
  
  public void draw()
  {
    
   flightInfo = new Widget(600, 200, 150, 300, "State:\n"+stateLabel + "\n  Avg Latenes:", color(255), stdFont, EVENT_NULL); // should display info on the state being highlighted but its not finished/
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
    

   stateWidgets[0] = new StateWidget(105,232,loadImage("Alaska.png"),"AK");
   stateWidgets[1] = new StateWidget(338,328,loadImage("Hawaii.png"),"HI");
   stateWidgets[2] = new StateWidget(143,54,loadImage("Washington.png"),"WA");
   stateWidgets[3] = new StateWidget(147, 90,loadImage("Oregon.png"),"OR");
   stateWidgets[4] = new StateWidget(152, 120,loadImage("California.png"),"CA");
   stateWidgets[5] = new StateWidget(178, 119,loadImage("Nevada.png"),"NV");
   stateWidgets[6] = new StateWidget(205, 63,loadImage("Idaho.png"),"ID");
   stateWidgets[7] = new StateWidget(212, 62,loadImage("Montana.png"),"MT");
   stateWidgets[8] = new StateWidget(244, 95,loadImage("Wyoming.png"),"WY");
   stateWidgets[9] = new StateWidget(295,62,loadImage("North Dakota.png"),"ND");
   stateWidgets[10] = new StateWidget(295,88,loadImage("South Dakota.png"),"SD");
   stateWidgets[11] = new StateWidget(295,114,loadImage("Nebraska.png"),"NE");
   stateWidgets[12] = new StateWidget(257,133,loadImage("Colorado.png"),"CO");
   stateWidgets[13] = new StateWidget(308,139,loadImage("Kansas.png"),"KS");
   stateWidgets[14] = new StateWidget(224,118,loadImage("Utah.png"),"UT");
   stateWidgets[15] = new StateWidget(218,164,loadImage("Arizona.png"),"AZ");
   stateWidgets[16] = new StateWidget(257,165,loadImage("New Mexico.png"),"NM");
   stateWidgets[17] = new StateWidget(274,167,loadImage("Texas.png"),"TX");
   stateWidgets[18] = new StateWidget(301,163,loadImage("Oklahoma.png"),"OK");
   stateWidgets[19] = new StateWidget(347,57,loadImage("Minnesota.png"),"MN");
   stateWidgets[20] = new StateWidget(346, 107,loadImage("Iowa.png"),"IA");
   stateWidgets[21] = new StateWidget(347,130,loadImage("Missouri.png"),"MO");
   stateWidgets[22] = new StateWidget(359,170,loadImage("Arkansas.png"),"AR");
   stateWidgets[23] = new StateWidget(365,202,loadImage("Louisiana.png"),"LA");
   stateWidgets[24] = new StateWidget(389,65,loadImage("Michigan.png"),"MI");
   stateWidgets[25] = new StateWidget(370,75,loadImage("Wisconsin.png"),"WI");
   stateWidgets[26] = new StateWidget(382,120,loadImage("Illinois.png"),"IL");
   stateWidgets[27] = new StateWidget(398,147,loadImage("Kentucky.png"),"KY");
   stateWidgets[28] = new StateWidget(392, 170,loadImage("Tennessee.png"),"TN");
   stateWidgets[29] = new StateWidget(378,182,loadImage("Missisippi.png"),"MS");
   stateWidgets[30] = new StateWidget(405,184,loadImage("Alabama.png"),"AL");
   stateWidgets[31] = new StateWidget(409,212,loadImage("Florida.png"),"HI");
   stateWidgets[32] = new StateWidget(423,183,loadImage("Georgia.png"),"GA");
   stateWidgets[33] = new StateWidget(442,182,loadImage("South Carolina.png"),"SC");
   stateWidgets[34] = new StateWidget(436,170,loadImage("North Carolina.png"),"NC");
   stateWidgets[35] = new StateWidget(443, 145,loadImage("Virginia.png"),"VA");
   stateWidgets[36] = new StateWidget(446,138,loadImage("West Virginia.png"),"WV");
   stateWidgets[37] = new StateWidget(409,126,loadImage("Indiana.png"),"IN");
   stateWidgets[38] = new StateWidget(429,120,loadImage("Ohio.png"),"OH");
   stateWidgets[39] = new StateWidget(461,116,loadImage("Pennsylvania.png"),"PA");
   stateWidgets[40] = new StateWidget(468,95,loadImage("New York.png"),"NY");
   stateWidgets[41] = new StateWidget(528,76,loadImage("Maine.png"),"ME");
   stateWidgets[42] = new StateWidget(513, 94,loadImage("Vermont.png"),"VT");
   stateWidgets[43] = new StateWidget(520,95,loadImage("New Hampshire.png"),"NH");
   stateWidgets[44] = new StateWidget(512,113,loadImage("Massachussetts.png"),"MA");
   stateWidgets[45] = new StateWidget(524, 120,loadImage("Rhode Island.png"),"RI");
   stateWidgets[46] = new StateWidget(513,120,loadImage("Connecticut.png"),"CT");
   stateWidgets[47] = new StateWidget(496,126,loadImage("New Jersey.png"),"NJ");
   stateWidgets[48] = new StateWidget(494, 139,loadImage("Delaware.png"),"Delaware");
   stateWidgets[49] = new StateWidget(468,140,loadImage("Maryland.png"),"MD");
   stateWidgets[50] = new StateWidget( 480,148,loadImage("Washington DC.png"),"DC");
   
  }
  
  
  
  
  
  
}
