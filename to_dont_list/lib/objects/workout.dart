import 'dart:ui';

enum Type {
  ab('Abs', Color.fromARGB(255, 255, 0, 0)),
  c('Cardio', Color.fromARGB(255, 112, 79, 162)),
  l('Legs', Color.fromARGB(224, 100, 0, 55)),
  a('Arms', Color.fromARGB(255, 0, 81, 255)),
  o('Other', Color.fromARGB(255, 128, 128, 128));

  const Type(this.label, this.rgbcolor);
  final String label;
  final Color rgbcolor;
}

class Workout {
  Workout({required this.name, required this.color, required this.type});

  final String name;
  final Color color;
  final Type type;
  int count = 1;

  void increment() {
    count++;
  }
}
