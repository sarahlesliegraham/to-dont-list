// Data class to keep the string and have an abbreviation function

class Item {
  const Item({required this.name});

  final String name;


// error was found in test, abbreviation should only be first letter
  String abbrev() {
    return name.substring(0, 1);
    //changed (0, 2) -> (0,1)
  }
}
