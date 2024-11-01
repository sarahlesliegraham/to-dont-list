import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/item.dart';
import 'package:to_dont_list/objects/rating.dart';
import 'package:to_dont_list/widgets/rating_dialog.dart';
import 'dart:math' as math;


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

      // https://stackoverflow.com/questions/65244903/how-to-draw-this-button-in-flutter-using-clippath    
      leading: ClipPath(
          clipper: StarClipper(6),
          child: FloatingActionButton(
            
        key: const Key("RatingButton"),
        
        onPressed: () {
        showDialog(
                  context: context,
                  builder: (_) {
                    return RatingDialog(onRatingAdded: _handleNewRating);
                  });
        },
        child: Text(widget.item.returnRating().toString()),
        backgroundColor: Colors.yellow,
      ),),

      
      title: Text(
        widget.item.name,
        style: widget._getTextStyle(context),
      ),
      subtitle: Text(
  '${widget.item.name2} at ${widget.item.name3}',
        style: widget._getTextStyle(context),
      ),
      trailing: Text(
  '${widget.item.name3} at ${widget.item.name4}',
        style: widget._getTextStyle(context),
      ),
    );
  }
}


// Star Button: https://stackoverflow.com/questions/63700728/flutter-how-to-draw-a-star
class StarClipper extends CustomClipper<Path> {
  StarClipper(this.numberOfPoints);

  /// The number of points of the star
  final int numberOfPoints;

  @override
  Path getClip(Size size) {
    double width = 55;
    print(width);
    double halfWidth = width / 2;

    double bigRadius = halfWidth;

    double radius = halfWidth / 1.3;

    num degreesPerStep = _degToRad(360 / numberOfPoints);

    double halfDegreesPerStep = degreesPerStep / 2;

    var path = Path();

    double max = 2 * math.pi;

    path.moveTo(width, halfWidth);

    for (double step = 0; step < max; step += degreesPerStep) {
      path.lineTo(halfWidth + bigRadius * math.cos(step),
          halfWidth + bigRadius * math.sin(step));
      path.lineTo(halfWidth + radius * math.cos(step + halfDegreesPerStep),
          halfWidth + radius * math.sin(step + halfDegreesPerStep));
    }

    path.close();
    return path;
  }

  num _degToRad(num deg) => deg * (math.pi / 180.0);

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    StarClipper oldie = oldClipper as StarClipper;
    return numberOfPoints != oldie.numberOfPoints;
  }

}

