// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/flora.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';
import 'package:to_dont_list/widgets/to_do_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  
  List<Flora> items = []; 
  final _itemSet = <Flora>{};
  late SharedPreferences savedList;
  
  getSharedPreferences() async {
    savedList = await SharedPreferences.getInstance();
    loadData();
  }
  saveData() {
    List<String> spList = items.map((item) => json.encode(item.toMap())).toList();
    savedList.setStringList('list', spList);
  }
  loadData() {
    List<String> spList = savedList.getStringList("list") ?? [];
    items = spList.map((item) => Flora.fromMap(json.decode(item))).toList();
    setState(() {
});
  }
  @override
  void initState() {
    getSharedPreferences();
    super.initState();
  }

  void _handleListChanged(Flora item, bool completed) {
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
      } else {
        print("Making Undone");
        _itemSet.remove(item);
        items.insert(0, item);
      }
    });
  }

  void _handleDeleteItem(Flora item) {
    setState(() {
      print("Deleting item");
      items.remove(item);
      saveData();
    });
  }

  void _handleNewItem(String itemText, FloraType type, TextEditingController textController) {
    setState(() {
      print("Adding new item");
      Flora item = Flora(name: itemText, type: type);
      items.insert(0, item);
      textController.clear();
      saveData();
    });
  }
  @override
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flora'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: items.map((item) {
            return FloraListItem(
              flora: item,
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
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    title: 'Flora List',
    home: ToDoList(),
  ));
}
