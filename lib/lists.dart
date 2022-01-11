import 'package:fit_wheel/workout.dart';
import 'package:flutter/material.dart';

Column getNewColumn(TextEditingController controller, String fieldName) {
  return Column(
    children: <Widget>[
      const Text('New Exercise'),
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

class EditList extends StatefulWidget {
  final Workout? workout;

  const EditList({Key? key, this.workout}) : super(key: key);

  @override
  _ELState createState() => _ELState();
}

class WorkoutList extends StatefulWidget {
  const WorkoutList({Key? key}) : super(key: key);

  @override
  _WLState createState() => _WLState();
}


class _State<T extends StatefulWidget> extends State<T> {

  var textFields = <Card>[];
  var myController = <TextEditingController>[];

  _onDone() {}

  Card createCard(String fieldName, {bool newCard = false}) {
    var controller = TextEditingController();
    myController.add(controller);
    return Card(
        child: newCard
            ? getNewColumn(controller, fieldName)
            : getItemColumn(controller, fieldName));
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
                  setState(() => textFields.add(createCard('Exercise Name'))),
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
          : getItemColumn(controller, fieldName),
    );
  }

  @override
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
    }
    Navigator.pop(context, Workout(vehicleName, vehicleNames, Icons.add));
  }
}

class _WLState extends _State<WorkoutList> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textFields.add(createCard('New Exercise Type', newCard: true));
  }

  @override
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
    }
    Navigator.pop(context, Workout(vehicleName, vehicleNames, Icons.add));
  }
}
