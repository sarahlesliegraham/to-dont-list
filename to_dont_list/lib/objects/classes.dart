import 'package:flutter/material.dart';

enum FoodGroup{
  red(Colors.red),
  blue(Colors.blue),
  brown(Colors.brown), 
  black(Colors.black),
  white(Colors.white),
  grey(Colors.grey );

  const FoodGroup(this.rgbcolor);

  final Color rgbcolor;
}
class Classes {

  Classes({required this.name,required this.color});
  final String name;
  final FoodGroup color;
  int count =1;
  
  void increment(){
    count++;
  }



}
