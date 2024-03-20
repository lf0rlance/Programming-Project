class Flights
{
  String[] singleFlightData;
  
  public Flights(String singleFlightData)
  {
    this.singleFlightData = singleFlightData.split(",", 20);
    this.singleFlightData[0] = this.singleFlightData[0].substring(0, 10);
    this.singleFlightData[4] = this.singleFlightData[4].substring(1, (this.singleFlightData[4].length()));
    this.singleFlightData[9] = this.singleFlightData[9].substring(1, (this.singleFlightData[9].length()));
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
  
  public int getDepTime()
  {
    if(singleFlightData[14] == "") return 0;
    else return Integer.parseInt(singleFlightData[14]);
  }  
  
  public int getCrsArrTime()
  {
    if(singleFlightData[15] == "") return 0;
    else return Integer.parseInt(singleFlightData[15]);
  }
  
  public int getArrTime()
  {
    if(singleFlightData[16] == "") return 0;
    else return Integer.parseInt(singleFlightData[16]);
  }  
  
  public int getCancelled()
  {
    if(singleFlightData[17] == "") return 0;
    else return Integer.parseInt(singleFlightData[17]);
  }

  public int getDiverted()
  {
    if(singleFlightData[18] == "") return 0;
    else return Integer.parseInt(singleFlightData[18]);
  }
  
  public int getDistance()
  {
    if(singleFlightData[19] == "") return 0;
    else return Integer.parseInt(singleFlightData[19]);
  }
  
    public void printFlightDetails() {
        System.out.println("Flight Details;  ");
        System.out.println("Flight Date: " + getFlightDate());
        System.out.println("Airline Code: " + getAirlineCode());
        System.out.println("Flight Number: " + getFlightNumber());
        System.out.println("Origin: " + getOrigin());
        System.out.println("Origin City Name: " + getOriginCityName());
        System.out.println("Origin State: " + getOriginState());
        System.out.println("Origin WAC: " + getOriginWac());
        System.out.println("Destination: " + getDestination());
        System.out.println("Destination City Name: " + getDestCityName());
        System.out.println("Destination State: " + getDestState());
        System.out.println("Destination WAC: " + getDestWac());
        System.out.println("Scheduled Departure Time: " + getCrsDepTime());
        System.out.println("Departure Time: " + getDepTime());
        System.out.println("Scheduled Arrival Time: " + getCrsArrTime());
        System.out.println("Arrival Time: " + getArrTime());
        System.out.println("Cancelled: " + getCancelled());
        System.out.println("Diverted: " + getDiverted());
        System.out.println("Distance: " + getDistance());
    }
  
}
