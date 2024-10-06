import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  
  double _currentVolume = 1;
  bool isckecked = false;
  bool light = false;
  bool _lights = false;
  double timeDilation = 1.0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
   List<int> items = List<int>.generate(10, (int index) => index);
  @override
  Widget build(BuildContext context) {
    var date = selectedDate;
    var time = selectedTime;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('title'),),
          body: Column(
            children: [
              Slider(
                value: _currentVolume, 
              max: 10,
              divisions: 5,
               label: _currentVolume.toString(),
               onChanged: 
                  ( double value){
                    setState(() {
                      _currentVolume = value;
                    });
                  }),
                  Checkbox(value: isckecked, onChanged:
                  (vlaue){
                    setState(() {
                      isckecked =vlaue!;
                    });
                  }),
                  Switch(
                    value: light, 
                    onChanged:(value){
                    setState(() {
                        light = value;
                    });
                  }),
                  CheckboxListTile(
        title: const Text('Animate Slowly'),
        value: timeDilation != 1.0,
        onChanged: (bool? value) {
          setState(() {
            timeDilation = value! ? 10.0 : 1.0;
          });
        },
        secondary: const Icon(Icons.hourglass_empty),
      ),
       SwitchListTile(
        title: const Text('Lights'),
        value: _lights,
        onChanged: (bool value) {
          setState(() {
            _lights = value;
          });
        },
        secondary: const Icon(Icons.lightbulb_outline),
      ),
       Text(
      date == null
          ? "You haven't picked a date yet."
          : DateFormat('MM-dd-yyyy').format(date),
    ),
    ElevatedButton.icon(
      icon: const Icon(Icons.calendar_today),
      onPressed: () async {
        var pickedDate = await showDatePicker(
          context: context,
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.now(),
          firstDate: DateTime(2019),
          lastDate: DateTime(2050),
        );

        setState(() {
          selectedDate = pickedDate;
        });
      },
      label: const Text('Pick a date'),
    ),
    Text(
      time == null ? "You haven't picked a time yet." : time.format(context),
    ),
    ElevatedButton.icon(
      icon: const Icon(Icons.calendar_today),
      onPressed: () async {
        var pickedTime = await showTimePicker(
          context: context,
          initialEntryMode: TimePickerEntryMode.dial,
          initialTime: TimeOfDay.now(),
        );

        setState(() {
          selectedTime = pickedTime;
        });
      },
      label: const Text('Pick a date'),
    ), 
    Expanded( // This ensures the ListView.builder takes up remaining space
            child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  background: Container(
                    color: Colors.green,
                  ),
                  key: ValueKey<int>(items[index]),
                  onDismissed: (DismissDirection direction) {
                    setState(() {
                      items.removeAt(index);
                    });
                  },
                  child: ListTile(
                    title: Text(
                      'Item ${items[index]}',
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Footer Widget',
              style: TextStyle(fontSize: 24),
            ),
          ),
            ],
          ),
      ),
    );

  }
}