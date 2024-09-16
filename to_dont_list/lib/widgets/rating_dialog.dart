import 'package:flutter/material.dart';

typedef RatingAddedCallback = Function(
    int stars);

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
  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text('Rate The Concert:'),
      content: Placeholder()
    );
  }
}