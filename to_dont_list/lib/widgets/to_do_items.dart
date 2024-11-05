import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/workout.dart';

typedef ToDoListChangedCallback = Function(Workout item, bool completed);
typedef ToDoListRemovedCallback = Function(Workout item);

//new class to update state when button pressed
class WorkoutListItem extends StatefulWidget {
  WorkoutListItem(
      {required this.workout,
      required this.completed,
      required this.onListChanged,
      required this.onDeleteItem})
      : super(key: ObjectKey(workout));

  final Workout workout;
  final bool completed;

  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeleteItem;
  @override
  State<WorkoutListItem> createState() => _WorkoutListItemState();
}

class _WorkoutListItemState extends State<WorkoutListItem> {
  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return widget.completed //
        ? Colors.black54
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!widget.completed) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        widget.onListChanged(widget.workout, widget.completed);
      },
      onLongPress: widget.completed
          ? () {
              widget.onDeleteItem(widget.workout);
            }
          : null,
      leading: ElevatedButton(
        //backgroundColor: _getColor(context),
        onPressed: () {
          setState(() {
            widget.workout.increment();
          });
        },
        child: Text(widget.workout.count.toString()),
        //number of workout in circle instead of abbrev
      ),
      title: Text(
        widget.workout.name,
        style: _getTextStyle(context),
      ),
      subtitle: Text(
        widget.workout.type.label,
        style: _getTextStyle(context),
      ),
    );
  }
}
