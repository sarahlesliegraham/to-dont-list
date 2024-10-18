// Data class to keep the string and have an abbreviation function

class Item {
  const Item({required this.name});

  final String name;

  String abbrev() {
    //changed this from name.substring(0,2) bc it should only be returning 1 letter
    return name.substring(0, 1);
  }
}
