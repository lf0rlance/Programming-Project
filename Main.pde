// main class
   Flights test[];

public void setup() {
  //flightsData = DataLoader.loadData("flights.csv");
  ArrayList<String> rawDataInArrayForm = new ArrayList<String>();  //need to clean up
  try //reading data from file
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
    test = new Flights[rawDataInArrayForm.size() - 1];
   for(int i = 0; i < rawDataInArrayForm.size() - 1; i++)
   {
     test[i] = new Flights(rawDataInArrayForm.get(i)); //missing last line of data when initialising
     System.out.println(test[i].getFlightDate());
   }
  // Add other setup code when needed
}

public void draw() {
  background(255);
  // Add code/functions to draw data on the screen
}

public void keyPressed() {
  // Handle mouse/keyboard inputs, update filters, etc.
}

// Other parts of the program
