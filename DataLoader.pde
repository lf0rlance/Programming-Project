class DataLoader {
  static ArrayList<DataPoint> loadData(String filename) {
    ArrayList<DataPoint> data = new ArrayList<>();
    String[] lines = loadStrings(filename);
    
    for (String line : lines) {
      String[] values = split(line, ',');
      DataPoint dataPoint = new DataPoint();
      // Set attributes of the dataPoint object based on values
      // Add the dataPoint object to the 'data' ArrayList
      data.add(dataPoint);
    }
    
    return data;
  }
}
