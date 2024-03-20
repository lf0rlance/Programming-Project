class Flights
{
  String[] singleFlightData;
  
  public Flights(String singleFlightData)
  {
    this.singleFlightData = singleFlightData.split(",", 20);
    this.singleFlightData[0] = this.singleFlightData[0].substring(0, 10);
    this.singleFlightData[4] = this.singleFlightData[4].substring(1, 
    (this.singleFlightData[4].length()));
    this.singleFlightData[9] = this.singleFlightData[9].substring(1, 
    (this.singleFlightData[9].length()));
  }
  
  public String getFlightDate()
  {
    return singleFlightData[0];
  }
  
  public String getAirlineCode()
  {
    return singleFlightData[1];
  }
  
  public int getFlightNumber()
  {
    if(singleFlightData[2] == "") return 0;
    else return Integer.parseInt(singleFlightData[2]);
  }
  
  public String getOrigin()
  {
    return singleFlightData[3];
  }
  
  public String getOriginCityName()
  {
    return singleFlightData[4];
  }
  
  public String getOriginState()
  {
    return singleFlightData[6];
  }
  
  public int getOriginWac()
  {
    if(singleFlightData[7] == "") return 0;
    else return Integer.parseInt(singleFlightData[7]);
  }
  
  public String getDestination()
  {
    return singleFlightData[8];
  }
  
  public String getDestCityName()
  {
    return singleFlightData[9];
  }
  
  public String getDestState()
  {
    return singleFlightData[11];
  }
  
  public int getDestWac()
  {
    if(singleFlightData[12] == "") return 0;
    else return Integer.parseInt(singleFlightData[12]);
  }
  
  public int getCrsDepTime()
  {
    if(singleFlightData[13] == "") return 0;
    else return Integer.parseInt(singleFlightData[13]);
  }
  
  public int getCrsArrTime()
  {
    if(singleFlightData[14] == "") return 0;
    else return Integer.parseInt(singleFlightData[14]);
  }
  
  public int getCancelled()
  {
    if(singleFlightData[15] == "") return 0;
    else return Integer.parseInt(singleFlightData[15]);
  }
  
  public int getDiverted()
  {
    if(singleFlightData[16] == "") return 0;
    else return Integer.parseInt(singleFlightData[16]);
  }
  
  public int getDistance()
  {
    if(singleFlightData[17] == "") return 0;
    else return Integer.parseInt(singleFlightData[17]);
  }
}
