import 'package:flutter/material.dart';

typedef ToDoListAddedCallback = Function(

    String value,
    String date,
    String time,
    String venue,
    TextEditingController textController,
    TextEditingController textController2,
    TextEditingController textController3);


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
  final TextEditingController _inputController2 = TextEditingController();
  final TextEditingController _inputController3 = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  String artistName = "";
  String selectedDate = "Select Date";
  String selectedTime = "Select Time";
  String selectedVenue = "";


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Concert'),
      content: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          TextField(
            key: const Key("ConcertField"),
            onChanged: (value) {
              setState(() {
                artistName = value;
              });
            },
            controller: _inputController,
            decoration: const InputDecoration(hintText: "Artist Name"),
          ),
          TextField(
            key: const Key("VenueField"),
            onChanged: (venue) {
              setState(() {
                selectedVenue = venue;
              });
            },
            controller: _inputController3,
            decoration: const InputDecoration(hintText: "Concert Venue"),
          ),

          const SizedBox(height: 20),
          Row(
            children: [
              const Text("Date"),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () async {
                  final DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2030),
                  );
                  if (date != null) {
                    setState(() {
                      selectedDate = '${date.month}/${date.day}/${date.year}';
                    });
                  }
                },
                child: Text(selectedDate),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text("Time"),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () async {
                  final TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    setState(() {
                      selectedTime = time.format(context);
                    });
                  }
                },
                child: Text(selectedTime),
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          key: const Key("CancelButton"),
          style: noStyle,
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // https://stackoverflow.com/questions/52468987/how-to-turn-disabled-button-into-enabled-button-depending-on-conditions
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _inputController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              style: yesStyle,
              onPressed: value.text.isNotEmpty &&
                      selectedDate != "Select Date" &&
                      selectedTime != "Select Time"
                  ? () {
                      widget.onListAdded(
                          artistName,
                          selectedDate,
                          selectedTime,
                          selectedVenue,
                          _inputController,
                          _inputController2,
                          _inputController3);

                      Navigator.pop(context);
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

//controller: _inputController3,
         // decoration: const InputDecoration(hintText: "Concert Venue"),