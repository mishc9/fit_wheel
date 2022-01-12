import 'package:fit_wheel/workout.dart';
import 'package:flutter/material.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';

Column getNewColumn(TextEditingController controller, String fieldName) {
  return Column(
    children: <Widget>[
      const Text('New Workout Name'),
      TextField(
          controller: controller,
          decoration: InputDecoration(labelText: fieldName)),
    ],
  );
}

Column getItemColumn(TextEditingController controller, String fieldName) {
  return Column(
    children: <Widget>[
      const Text('New Exercise'),
      TextField(
          controller: controller,
          decoration: InputDecoration(labelText: fieldName)),
    ],
  );
}


class WorkoutService {
  var exercises = <String>[];

  List<String> getSuggestions(String pattern) {
    return exercises.where((element) => element.startsWith(pattern)).toList();
  }

  void add(String name) {
    if (!exercises.contains(name)) {
      exercises.add(name);
    }
  }
}

abstract class StatefulList extends StatefulWidget {
  final WorkoutService? service;

  const StatefulList({Key? key, this.service, }) : super(key: key);
}


class EditList extends StatefulList {
  final Workout? workout;
  final WorkoutService? service;

  const EditList({Key? key, this.service, this.workout,}) : super(key: key);

  @override
  _ELState createState() => _ELState();
}

class WorkoutList extends StatefulList {
  final WorkoutService? service;

  const WorkoutList({Key? key, this.service,}) : super(key: key);

  @override
  _WLState createState() => _WLState();
}


class _State<T extends StatefulList> extends State<T> {
  var textFields = <Card>[];
  var myController = <TextEditingController>[];
  WorkoutService? service;

  Widget getDropdownColumn(TextEditingController controller,
      String fieldName,
      WorkoutService service) {
    var field = TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          controller: controller,
          decoration: const InputDecoration(
              labelText: 'Exercise name'
          )
      ),
      suggestionsCallback: (pattern) {
        return service.getSuggestions(pattern);
      },
      itemBuilder: (context, String suggestion) {
        return ListTile(
          title: Text(suggestion),
        );
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: (String suggestion) {
        controller.text = suggestion;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please select a city';
        }
      },
    );
    return field;
  }

  _onDone() {
    if (myController.isEmpty) {
      return;
    }
    var vehicleName = myController[0].text;
    if (myController.length == 1) {
      Navigator.pop(context, Workout(vehicleName, [], Icons.add));
      return;
    }
    List<String> vehicleNames = <String>[];
    for (int i = 1; i < textFields.length; i++) {
      var name = myController[i].text;
      vehicleNames.add(name);
      widget.service!.add(name);
    }
    Navigator.pop(context, Workout(vehicleName, vehicleNames, Icons.add));
  }

  Card createCard(String fieldName, {bool newCard = false}) {
    var controller = TextEditingController();
    myController.add(controller);
    return Card(
        child: newCard
            ? getNewColumn(controller, fieldName)
            : getDropdownColumn(controller, fieldName, widget.service!)
      // : getItemColumn(controller, fieldName));
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Exercise",
          style: TextStyle(fontSize: 19),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: textFields.length,
              itemBuilder: (BuildContext context, int index) {
                return textFields[index];
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: const Text('Add new exercise'),
              onPressed: () =>
                  setState(() {
                    var card = createCard('Exercise Name');
                    textFields.add(card);
                  }),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.done), onPressed: _onDone),
    );
  }
}


class _ELState extends _State<EditList> {

  @override
  void initState() {
    super.initState();
    final controller = TextEditingController(text: widget.workout!.title);
    myController.add(controller);
    textFields.add(initCard('New Exercise', controller, newCard: true));
    for (int i = 0; i < widget.workout!.contents.length; i++) {
      final controller =
      TextEditingController(text: widget.workout!.contents[i]);
      myController.add(controller);
      textFields.add(initCard('Exercise Name', controller));
    }
  }

  Card initCard(String fieldName, TextEditingController controller,
      {bool newCard = false}) {
    return Card(
        child: newCard
            ? getNewColumn(controller, fieldName)
            : getDropdownColumn(controller, fieldName, widget.service!)
      // : getItemColumn(controller, fieldName),
    );
  }
}

class _WLState extends _State<WorkoutList> {
  @override
  void initState() {
    super.initState();
    textFields.add(createCard('New Exercise Type', newCard: true));
  }
}
