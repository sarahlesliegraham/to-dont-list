//change app to be flora (and fauna?) tracker
//option to add location

class Flora {
  Flora({required this.name});

  final String name;

  int numLocations = 1;

  String getNumLocations(){
    return numLocations.toString();
  }

  void addNumLocation(){
    numLocations ++;
  }
}