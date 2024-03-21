
class BarChart{
  
  int dataType;
  String title;
  
  int xpos;
  int ypos;
  
  // the dataTypes used in constructor to show which values the bar chart is showin
  final int FLIGHT_DATE = 1;
  final int AIRLINE_CODE = 2;
  final int FLIGHT_NUMBER = 3;
  final int ORIGIN = 4;
 
  final int ORIGIN_CITY_NAME = 5;
  
  final int ORIGIN_STATE =  6;
  final int ORIGIN_WAC = 7;
  final int DESTINATION = 8;
  
  int startingIndex;
 
 
  //Flights flight;
  
  ArrayList<String> dataList;
  IntList frequency;
  
  
  
  
  BarChart(int xpos, int ypos, int dataType){
    startingIndex = 0;
    this.xpos = xpos;
    this.ypos = ypos;
    
    this.dataType = dataType;
    
    /*  Creates an ArrayList of the data tyoe*/
    dataList = new ArrayList<String>();            
    
    for(int i = 0; i < allFlightData.length; i++)
    {
      boolean found = false;
      Flights currentFlight = allFlightData[i];
      String data = getData(currentFlight);        // gets the required data for the flight(e.g origin city, destination)
      
      for(String temp: dataList)
      {
        if(data.equals(temp)) found = true;  // if data is already in the dataList, found = true
        
      }
      if(!found) dataList.add(data);  // only adds data to the data list if the dataList does not have the data already.
                                      // (e.g if t "Dublin" is added to dataList once, it will not be added again.)
    }
    
    
    /*  Creates an ArrayList of the frequency of each data type*/
    
   frequency = new IntList();         
   for(int i = 0; i < dataList.size();i++)
   {
     int count = 0;
     String currentString = dataList.get(i); 
    

     for(Flights currentFlight: allFlightData) // itterates through each flight in the allFlightData array
     {
       String data = getData(currentFlight);
       if(data.equals(currentString)) count+=1; //  counts how many times the data in dataList appears in the allFlightData array
     }
     frequency.append(count); // the total count is stored in the frequency arrayList
   }
   
   
     
     //System.out.print(dataList.size());
  
    
    
  }
  
  public void draw()
  { 
    int actualIndex = 0;  // the positioning of each bar( 0 = first bar, 1 = second bar etc);
    for(int i = startingIndex; i < startingIndex + 5; i++)
    {
      
      //  in the future, make the size  and spacing of the text dependent on; 1.) the amount of datapoints  on the chart 2.) the size of the chart itself.(i.e.Scale the bar chart).
      
      // we may also arrange the barchart in order of frequency, or alphabetical order (or create a method to do so)
      
      // for visibiility purposes, we may choose to show a certain number of bars per time, and let the user choose to see more data
      
      String label = dataList.get(i);  
      int count = frequency.get(i);      // get data and corresponding frequency
      stroke(0);
      fill(count,0,0);// the "redness" depends on the frequency
      rect(xpos, ypos + actualIndex*45, count,20);
      fill(0);
      text(title, 100, ypos-10);
      text( label, 10, 300 + actualIndex* 45 );
      text(count , 400, 300 + actualIndex* 45 );
      actualIndex+=1;
    }
  }
  
  
  public void scroll()
  {
    startingIndex += 5;
  }
  

  
  
  
  
  
  
  
  
  
  
  public String getData(Flights flight)
  {
   switch(dataType)
  {
    case ORIGIN_CITY_NAME:
       title = "Origin City Name";
       return flight.getOriginCityName();
     case ORIGIN_STATE:
       title = "Origin State";
      return flight.getOriginState();
     case DESTINATION:
       title = "Destination";
       return flight.getDestination();
       
    default:
      return "";
  }
  
    
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
