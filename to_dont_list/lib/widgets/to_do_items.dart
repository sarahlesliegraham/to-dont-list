import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/item.dart';
import 'package:to_dont_list/objects/rating.dart';
import 'package:to_dont_list/widgets/rating_dialog.dart';

typedef ToDoListChangedCallback = Function(Item item, bool completed);
typedef ToDoListRemovedCallback = Function(Item item);
class ToDoListItem extends StatelessWidget {
  ToDoListItem(
      {required this.item,
      required this.completed,
      required this.onListChanged,
      required this.onDeleteItem})
      : super(key: ObjectKey(item));
  final Item item;
  final bool completed;
  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeleteItem;
  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.
    return completed //
        ? Colors.black54
        : Theme.of(context).primaryColor;
  }
  TextStyle? _getTextStyle(BuildContext context) {
    if (!completed) return null;
    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  void _handleNewRating(int starRating) {
    Rating rating = Rating(stars: starRating);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onListChanged(item, completed);
      },
      onLongPress: completed
          ? () {
              onDeleteItem(item);
            }
          : null,
      leading: FloatingActionButton(
        onPressed: () {
        showDialog(
                  context: context,
                  builder: (_) {
                    return RatingDialog(onRatingAdded: _handleNewRating);
                  });
        },
        child: Text(item.abbrev()),
      ),
      title: Text(
        item.name,
        style: _getTextStyle(context),
      ),
      subtitle: Text(
        item.name2,
        style: _getTextStyle(context),
      )
    );
  }
}