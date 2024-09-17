// Data class to keep the string and have an abbreviation function

class Item {
  Item({required this.name, required this.name2, required this.rating});

  final String name;
  final String name2;
  int rating;


  int abbrev() {
    return rating;
  }
}
