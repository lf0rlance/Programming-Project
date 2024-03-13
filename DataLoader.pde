//class to read in data from csv file and initialise global variables with appropriate data
import java.io.FileReader;
import java.io.BufferedReader;
import java.util.ArrayList;
class DataLoader
{
  ArrayList<String> rawDataInArrayForm;
  
  public DataLoader() //constructor initialises ArrayList with element being a line in csv file
  {
    try
    {
      BufferedReader flights = createReader("flights2k.csv");
      String currentLine;
      rawDataInArrayForm = new ArrayList<String>();
      int i = 0;
      while((currentLine = flights.readLine()) != null)
      {
        if(i != 0)
        {
          rawDataInArrayForm.add(currentLine);
        }
        i++;
      }
      flights.close();
    }
    catch(Exception e)
    {
      System.out.println("Error at DataLoader Class constructor");
    }
  }
  
  public void setDataArrays() //organises data in appropriate arrays for easy use
  {
     flightDate = new  String[rawDataInArrayForm.size()];
     airlineCode = new  String[rawDataInArrayForm.size()];
     flightNumber = new  int[rawDataInArrayForm.size()];
     origin = new  String[rawDataInArrayForm.size()];
     originCityName = new  String[rawDataInArrayForm.size()];
     originState = new  String[rawDataInArrayForm.size()];
     originWac = new  int[rawDataInArrayForm.size()];
     destination = new  String[rawDataInArrayForm.size()];
     destCityName = new  String[rawDataInArrayForm.size()];
     destState = new  String[rawDataInArrayForm.size()];
     destWac = new  int[rawDataInArrayForm.size()];
     crsDepTime = new  int[rawDataInArrayForm.size()];
     depTime = new  int[rawDataInArrayForm.size()];
     crsArrTime = new  int[rawDataInArrayForm.size()];
     arrTime = new  int[rawDataInArrayForm.size()];
     cancelled = new  int[rawDataInArrayForm.size()];
     diverted = new  int[rawDataInArrayForm.size()];
     distance = new  int[rawDataInArrayForm.size()];
     for(int i = 0; i < rawDataInArrayForm.size(); i++)
     {
        String[] splitLine = rawDataInArrayForm.get(i).split(",");
        flightDate[i] = splitLine[0];
        airlineCode[i] = splitLine[1];
        flightNumber[i] = Integer.parseInt(splitLine[2]);
        origin[i] = splitLine[3];
        originCityName[i] = splitLine[4] + "," + splitLine[5];
        originState[i] = splitLine[6];
        originWac[i] = Integer.parseInt(splitLine[7]);
        destination[i] = splitLine[8];
        destCityName[i] = splitLine[9] + "," + splitLine[10];
        destState[i] = splitLine[11];
        destWac[i] = Integer.parseInt(splitLine[12]);
        crsDepTime[i] = Integer.parseInt(splitLine[13]);
        if(splitLine[14] == "") depTime[i] = -1;
        else depTime[i] = Integer.parseInt(splitLine[14]);
        crsArrTime[i] = Integer.parseInt(splitLine[15]);
        if(splitLine[16] == "") arrTime[i] = -1;
        else arrTime[i] = Integer.parseInt(splitLine[16]);
        cancelled[i] = Integer.parseInt(splitLine[17]);
        diverted[i] = Integer.parseInt(splitLine[18]);
        distance[i] = Integer.parseInt(splitLine[19]);
     }
  }
  //note: function needs to clean up flightDate, deleting 00:00 to make data as easy to use
  //as possible
}
