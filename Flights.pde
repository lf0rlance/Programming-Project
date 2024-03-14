class Flights  //need to make more efficient (move split to  constructor)
{
  String singleFlightData;
  
  public Flights(String singleFlightData)
  {
    this.singleFlightData = singleFlightData;
  }
  
  public String getFlightDate()
  {
    String[] temp = singleFlightData.split(",", 2);
    return temp[0];
  }
  
  public String getAirlineCode()
  {
    String[] temp = singleFlightData.split(",", 3);
    return temp[1];
  }
  
  public int getFlightNumber()
  {
    String[] temp = singleFlightData.split(",", 4);
    return Integer.parseInt(temp[2]);
  }
  
  public String getOrigin()
  {
    String[] temp = singleFlightData.split(",", 5);
    return temp[3];
  }
  
  public String getOriginCityName()
  {
    String[] temp = singleFlightData.split(",", 6);
    return temp[4];
  }
  
  public String getOriginState()
  {
    String[] temp = singleFlightData.split(",", 8);
    return temp[6];
  }
  
  public int getOriginWac()
  {
    String[] temp = singleFlightData.split(",", 9);
    return Integer.parseInt(temp[7]);
  }
  
  public String getDestination()
  {
    String[] temp = singleFlightData.split(",", 10);
    return temp[8];
  }
  
  public String getDestCityName()
  {
    String[] temp = singleFlightData.split(",", 11);
    return temp[9];
  }
  
  public String getDestState()
  {
    String[] temp = singleFlightData.split(",", 13);
    return temp[11];
  }
  
  public int getDestWac()
  {
    String[] temp = singleFlightData.split(",", 14);
    return Integer.parseInt(temp[12]);
  }
  
  public int getCrsDepTime()
  {
    String[] temp = singleFlightData.split(",", 15);
    return Integer.parseInt(temp[13]);
  }
  
  public int getCrsArrTime()
  {
    String[] temp = singleFlightData.split(",", 16);
    return Integer.parseInt(temp[14]);
  }
  
  public int getCancelled()
  {
    String[] temp = singleFlightData.split(",", 17);
    return Integer.parseInt(temp[15]);
  }
  
  public int getDiverted()
  {
    String[] temp = singleFlightData.split(",", 18);
    return Integer.parseInt(temp[16]);
  }
  
  public int getDistance()
  {
    String[] temp = singleFlightData.split(",", 18);
    return Integer.parseInt(temp[17]);
  }
}
