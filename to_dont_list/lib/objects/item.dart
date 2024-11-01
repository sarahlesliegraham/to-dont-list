// Data class to keep the string and have an abbreviation function

class Item {
  Item(
      {required this.name,
      required this.name2,
      required this.name3,
      required this.name4,
      required this.rating});


  final String name;
  final String name2;
  final String name3;

  final String name4;
  int rating;

  int returnRating() {
    return rating;
  }
}
