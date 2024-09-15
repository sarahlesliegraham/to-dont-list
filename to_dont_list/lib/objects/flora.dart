//change app to be flora (and fauna?) tracker
//option to add location
import 'package:flutter/material.dart';

enum FloraType{
  native(Colors.green),
  garden(Colors.pink),
  weed(Colors.brown),
  ;

  const FloraType(this.rgbColor);

  final Color rgbColor;
}

class Flora {
  Flora({required this.name, required this.type});

  final String name;

  final FloraType type;

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