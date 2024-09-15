//change app to be flora (and fauna?) tracker
//option to add location
import 'package:flutter/material.dart';

enum FloraType{
  native(Color.fromARGB(255, 113, 220, 116)),
  garden(Color.fromARGB(255, 246, 137, 137)),
  weed(Color.fromARGB(255, 195, 141, 121)),
  unknown(Colors.grey),
  ;

  const FloraType(this.rgbColor);

  final Color rgbColor;

}

class Flora {
  Flora({required this.name, required this.type});

  final String name;

  FloraType type;

  int numLocations = 1;

  String getNumLocations(){
    return numLocations.toString();
  }

  void addNumLocation(){
    numLocations ++;
  }
}


//types of flora
// Native flora. The native and indigenous flora of an area.
//Agricultural and horticultural flora (garden flora). The plants that are deliberately grown by humans.
//Weed flora. 