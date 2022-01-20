import 'package:fit_wheel/planner/suggestor.dart';
import 'package:flutter/material.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';

// Todo: make a factory of Widgets to untie from Workout class
import '../workout.dart';

abstract class StatefulList extends StatefulWidget {
  final WorkoutSuggestor? suggestor;

  const StatefulList({
    Key? key,
    this.suggestor,
  }) : super(key: key);
}

class ListState<T extends StatefulList> extends State<T> {
  var textFields = <Card>[];
  var myController = <TextEditingController>[];
  WorkoutSuggestor? service;

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

  Widget getDropdownColumn(TextEditingController controller, String fieldName,
      WorkoutSuggestor service) {
    var field = TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Exercise name')),
      suggestionsCallback: (pattern) {
        return service.getSuggestions(pattern);
      },
      itemBuilder: (context, String suggestion) {
        return ListTile(title: Text(suggestion));
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
    var workoutName = myController[0].text;
    if (myController.length == 1) {
      Navigator.pop(
          context, Workout(title: workoutName, contents: [], icon: Icons.add));
      return;
    }
    List<String> exerciseNames = <String>[];
    for (int i = 1; i < textFields.length; i++) {
      var name = myController[i].text;
      exerciseNames.add(name);
      widget.suggestor!.add(name);
    }
    Navigator.pop(context,
        Workout(title: workoutName, contents: exerciseNames, icon: Icons.add));
  }

  Card createCard(String fieldName, {bool newCard = false}) {
    var controller = TextEditingController();
    myController.add(controller);
    return Card(
        child: newCard
            ? getNewColumn(controller, fieldName)
            : getDropdownColumn(controller, fieldName, widget.suggestor!)
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
              onPressed: () => setState(() {
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
