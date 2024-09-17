// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/classes.dart';
import 'package:to_dont_list/objects/item.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';
import 'package:to_dont_list/widgets/to_do_dialog.dart';


class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<Classes> items = [Classes(name: "Food", color: FoodGroup.vegetable)];
  final _itemSet = <Classes>{};

  //add a final count for servings
  final Map<FoodGroup, int> foodGroupCounts = {
    for (var group in FoodGroup.values) group: 0
  };

  void _handleListChanged(Classes item, bool completed) {
    setState(() {
      // When a user changes what's in the list, you need
      // to change _itemSet inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      items.remove(item);
      if (!completed) {
        print("Completing");
        _itemSet.add(item);
        items.add(item);
        foodGroupCounts[item.color] = foodGroupCounts[item.color]! + 1;
      } else {
        print("Making Undone");
        _itemSet.remove(item);
        items.insert(0, item);
        foodGroupCounts[item.color] = foodGroupCounts[item.color]! - 1;
      }
    });
  }

  void _handleDeleteItem(Classes item) {
    setState(() {
      print("Deleting item");
      items.remove(item);
      foodGroupCounts[item.color] = foodGroupCounts[item.color]! - 1;
    });
  }

  void _handleNewItem(String itemText, FoodGroup food, TextEditingController textController) {
    setState(() {
      print("Adding new item");
      //changed this to get rid of the constant
      Classes item = Classes(name: itemText, color: food);
      items.insert(0, item);
      foodGroupCounts[food] = foodGroupCounts[food]! + 1;
      textController.clear();
    });
  }

  void _showTotalDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Total Servings'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: foodGroupCounts.entries.map((entry) {
                return Text('${entry.key.name}: ${entry.value}');
              }).toList(),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Servings  Food List'),
          actions: [
            IconButton(
              icon: const Icon(Icons.calculate),
              onPressed: _showTotalDialog,
            )
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: items.map((item) {
            return ClassListItem(
              course: item,
              completed: _itemSet.contains(item),
              onListChanged: _handleListChanged,
              onDeleteItem: _handleDeleteItem,
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return ToDoDialog(onListAdded: _handleNewItem);
                  });
            }));
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Food List',
    home: ToDoList(),
  ));
}
