enum StarRating {
  one(1),
  two(2),
  three(3),
  four(4),
  five(5);

  const StarRating(this.rating);
  final int rating;
}

class Rating {
  const Rating({required this.stars});

  final int stars;

  
}