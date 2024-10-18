import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/classes.dart';

typedef FoodListAddedCallback = Function(
    String value, FoodGroup food ,TextEditingController textConroller);

class FoodDialog extends StatefulWidget {
  const FoodDialog({
    super.key,
    required this.onListAdded,
  });

  final FoodListAddedCallback onListAdded;

  @override
  State<FoodDialog> createState() => _FoodDialogState();
}

class _FoodDialogState extends State<FoodDialog> {
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
      title: const Text('Add a Food'),
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
                food ?? FoodGroup.vegetable, 
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
