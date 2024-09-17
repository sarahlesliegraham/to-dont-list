import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/classes.dart';

typedef ToDoListAddedCallback = Function(
    String value, FoodGroup food ,TextEditingController textConroller);

class ToDoDialog extends StatefulWidget {
  const ToDoDialog({
    super.key,
    required this.onListAdded,
  });

  final ToDoListAddedCallback onListAdded;

  @override
  State<ToDoDialog> createState() => _ToDoDialogState();
}

class _ToDoDialogState extends State<ToDoDialog> {
  // Dialog with text from https://www.appsdeveloperblog.com/alert-dialog-with-a-text-field-in-flutter/
  final TextEditingController _inputController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  String valueText = "";
  FoodGroup? food;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Item To Add'),
      content: Column(children:[TextField(
        onChanged: (value) {
          setState(() {
            valueText = value;
          });
        },
        controller: _inputController,
        decoration: const InputDecoration(hintText: "type something here"),
      ),
      DropdownButton<FoodGroup>(
        value: food,
        onChanged: (FoodGroup? newValue) {
          setState(() {
            food = newValue!;
          });
        },
        items: FoodGroup.values.map((FoodGroup classType) {
          return DropdownMenuItem<FoodGroup> (
            value: classType, child: Text(classType.name));
        }).toList())
      ],
      ),
      
      actions: <Widget>[
        ElevatedButton(
          //changed OkButton to OKButton
          key: const Key("OKButton"),
          style: yesStyle,
          child: const Text('OK'),
          onPressed: () {
            setState(() {
              widget.onListAdded(
                valueText,
                food ?? FoodGroup.red, // Use selected food or default to FoodGroup.red
                _inputController,
              );
              Navigator.pop(context);
            });
          },
        ),

        // https://stackoverflow.com/questions/52468987/how-to-turn-disabled-button-into-enabled-button-depending-on-conditions
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _inputController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("CancelButton"),
              style: noStyle,
              onPressed: value.text.isNotEmpty
                  ? () {
                      setState(() {
                        //widget.onListAdded(valueText, _inputController);
                        Navigator.pop(context);
                      });
                    }
                  : null,
              child: const Text('Cancel'),
            );
          },
        ),
      ],
    );
  }
}
