//change app to be flora (and fauna?) tracker
//option to add location
import 'package:flutter/material.dart';

enum FloraType {
  native(Color.fromARGB(255, 113, 220, 116), 'lib/pictures/native.jpg'),
  garden(Color.fromARGB(255, 246, 137, 137), 'lib/pictures/garden.jpg'),
  weed(Color.fromARGB(255, 195, 141, 121), 'lib/pictures/weed.jpg'),
  unknown(Colors.grey, 'lib/pictures/unknown.jpg'),
  ;

  const FloraType(this.rgbColor, this.imagePath);

  final Color rgbColor;
  final String imagePath;
}

class Flora {
  Flora({
    required this.name,
    required this.color,
    required this.type,
    required this.imagePath,
  });

  final String name;
  final Color color;
  final String imagePath;
  FloraType type;

  int numLocations = 1;

  String getNumLocations() {
    return numLocations.toString();
  }

  void addNumLocation() {
    numLocations++;
  }
}


//types of flora
// Native flora. The native and indigenous flora of an area.
//Agricultural and horticultural flora (garden flora). The plants that are deliberately grown by humans.
//Weed flora. 