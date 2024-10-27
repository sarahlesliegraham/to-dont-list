import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/item.dart';
import 'package:to_dont_list/objects/rating.dart';
import 'package:to_dont_list/widgets/rating_dialog.dart';

typedef ToDoListChangedCallback = Function(Item item, bool completed);
typedef ToDoListRemovedCallback = Function(Item item);

class ToDoListItem extends StatefulWidget {
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

  @override
  State createState() => _ToDoListItemState();
}

class _ToDoListItemState extends State<ToDoListItem> {
  void _handleNewRating(int starRating) {
    setState(() {
      widget.item.rating = starRating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          widget.onListChanged(widget.item, widget.completed);
        },
        onLongPress: widget.completed
            ? () {
                widget.onDeleteItem(widget.item);
              }
            : null,
        leading: FloatingActionButton(
          key: const Key("RatingButton"),
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return RatingDialog(onRatingAdded: _handleNewRating);
                });
          },
          child: Text(widget.item.returnRating().toString()),
        ),
        title: Text(
          widget.item.name,
          style: widget._getTextStyle(context),
        ),
        subtitle: Text(
          widget.item.name2,
          style: widget._getTextStyle(context),
        ));
  }
}
