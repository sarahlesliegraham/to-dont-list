import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/rating.dart';
import 'dart:math' as math;

typedef RatingAddedCallback = Function(int stars);

class RatingDialog extends StatefulWidget {
  const RatingDialog({
    super.key,
    required this.onRatingAdded,
  });

  final RatingAddedCallback onRatingAdded;

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  StarRating ratingValue = StarRating.one;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Rate The Concert:'),
      content: DropdownButton<StarRating>(
          key: const Key('RatingDropDown'),
          value: ratingValue,
          onChanged: (StarRating? newValue) {
            setState(() {
              ratingValue = newValue!;
            });
          },
          items: StarRating.values.map((StarRating classType) {
            return DropdownMenuItem<StarRating>(
                value: classType, child: Text(classType.name));
          }).toList()),
      actions: <Widget>[
        ElevatedButton(
          key: const Key("OKButton"),
          child: const Text('OK'),
          onPressed: () {
            setState(() {
              widget.onRatingAdded(ratingValue.rating);
              Navigator.pop(context);
            });
          },
        )
      ],
    );
  }
}

