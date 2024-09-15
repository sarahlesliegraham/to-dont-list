//WIP

class Location {
  Location({required this.name});

  final String name;
  int numOfFlora = 0;

  
  void addNumOfFlora(){
    numOfFlora ++;
  }

  String getNumOfFlora(){
    return numOfFlora.toString();
  }
}