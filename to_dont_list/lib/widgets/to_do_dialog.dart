import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/workout.dart';

typedef ToDoListAddedCallback = Function(
    String value, Type type, TextEditingController textConroller);

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
  final TextEditingController _typeController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);
  Type? selectedType = Type.a;

  String valueText = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Item To Add'),
      content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        TextField(
          onChanged: (value) {
            setState(() {
              valueText = value;
            });
          },
          controller: _inputController,
          decoration: const InputDecoration(hintText: "Enter workout name"),
        ),
        const SizedBox(height: 12),
        //used https://api.flutter.dev/flutter/material/DropdownMenu-class.html
        DropdownMenu<Type>(
          initialSelection: Type.a,
          controller: _typeController,
          label: const Text('Type'),
          onSelected: (Type? type) {
            setState(() {
              selectedType = type;
            });
          },
          dropdownMenuEntries:
              Type.values.map<DropdownMenuEntry<Type>>((Type type) {
            return DropdownMenuEntry<Type>(
              value: type,
              label: type.label,
            );
          }).toList(),
        ),
      ]),

      // https://stackoverflow.com/questions/52468987/how-to-turn-disabled-button-into-enabled-button-depending-on-conditions
      actions: <Widget>[
        ElevatedButton(
          key: const Key("CancelButton"),
          style: noStyle,
          child: const Text('Cancel'),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),

        // https://stackoverflow.com/questions/52468987/how-to-turn-disabled-button-into-enabled-button-depending-on-conditions
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _inputController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              style: yesStyle,
              onPressed: value.text.isNotEmpty
                  ? () {
                      setState(() {
                        widget.onListAdded(
                            valueText, selectedType!, _inputController);
                        Navigator.pop(context);
                      });
                    }
                  : null,
              child: const Text('OK'),
            );
          },
        ),
      ],
    );
  }
}
