// Data class to keep the string and have an abbreviation function

class Item {
  const Item({required this.name});

  final String name;


// test for this did not pass, abbreviation should only be first letter. Original function returned first 2 letters.
  String abbrev() {
    return name.substring(0, 1);
    //changed (0, 2) -> (0,1)
  }
}
