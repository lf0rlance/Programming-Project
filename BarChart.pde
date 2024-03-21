
class BarChart{
  
  int event;
  
  int xpos;
  int ypos;
  
  int FLIGHT_DATE = 1;
  int AIRLINE_CODE = 2;

  int FLIGHT_NUMBER = 3;
  int ORIGIN = 4;
  
  
  final int ORIGIN_CITY_NAME = 5;
  
  
  final int ORIGIN_STATE =  6;
  final int ORIGIN_WAC = 7;
  final int DESTINATION = 8;
  
  int startingIndex;
  int endingIndex = startingIndex + 5;
 
  

  
  ArrayList<String> dataList;
  IntList frequency;
  
  Flights flight;
  
  
  BarChart(int xpos, int ypos, int event){
    startingIndex = 4;
    this.xpos = xpos;
    this.ypos = ypos;
    
    this.event = event;
    
    dataList = new ArrayList<String>();            // create an arrayList of Origin Cities
    
    for(int i = 0; i < allFlightData.length; i++)
    {
      boolean found = false;
      this.flight = allFlightData[i];
      String data = getData();  
      for(String temp: dataList)
      {
        if(data.equals(temp)) found = true;  
        
      }
      if(!found) dataList.add(data);  // if hte arrayList already has the origin city, do not add it(avoids duplicates)
    }
   frequency = new IntList();          //  creates an arrayList of the frequency of flights from each origin city - maybe attempt to do the same thing in the previous for loop
     for(int i = 0; i < dataList.size();i++)
     {
       int count = 0;
       String currentString = dataList.get(i);
       for(Flights currentFlight: allFlightData)
       {
         if(currentFlight.getOriginCityName().equals(currentString)) count+=1;
       }
       
       frequency.append(count);
     }
     
     //System.out.print(dataList.size());
  
    
    
  }
  
  public void draw()
  { 
    int actualIndex = 0;
    for(int i = startingIndex; i < startingIndex + 5; i++)
    {
      
      //  in the future, make the size  and spacing of the text dependent on; 1.) the amount of datapoints  on the chart 2.) the size of the chart itself.(Scale the bar chart).
      // we may also arrange the barchart in order of frequency, or alphabetical order (or create a method to do so)
      // for visibiility purposes, we may choose to show a certain number of bars per time, and let the user choose to see more data
      String label = dataList.get(i);
      int count = frequency.get(i);
      stroke(0);
      fill(count,0,0);
      rect(xpos, ypos + actualIndex*45, count,20);
      fill(0);
      text( label, 10, 300 + actualIndex* 45 );
      text(count , 400, 300 + actualIndex* 45 );
      actualIndex+=1;
    }
  }
  
  
  
  
  
  
  
  
  
  
  public String getData()
  {
   switch(event)
  {
    case ORIGIN_CITY_NAME:
       return flight.getOriginCityName();
       
    default:
      return "";
  }
  
    
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
