// main class
Flights allFlightData[];

public void setup() 
{
  //reading data from file and organising into object array for useage ************************
  ArrayList<String> rawDataInArrayForm = new ArrayList<String>();
  try 
    {
      BufferedReader flights = createReader("flights2k.csv");
      String currentLine;
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
    allFlightData = new Flights[rawDataInArrayForm.size()];
   for(int i = 0; i < rawDataInArrayForm.size(); i++)
   {
     allFlightData[i] = new Flights(rawDataInArrayForm.get(i));
   }
  //*******************************************************************************************
  
}

public void draw() {
  background(255);
  // Add code/functions to draw data on the screen
}

public void keyPressed() {
  // Handle mouse/keyboard inputs, update filters, etc.
}

// Other parts of the program
