import 'package:fit_wheel/planner/suggestor.dart';
import 'package:fit_wheel/planner/updater.dart';
import 'package:fit_wheel/planner/planner.dart';
import 'package:fit_wheel/workout.dart';
import 'package:flutter/material.dart';

import 'planner/planner.dart';

void main() {
  runApp(const MaterialApp(
    title: "My Test App",
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Todo: find out how does the GlobalKey work. I don't really need it here,
  // though
  final _formKey = GlobalKey<FormState>();

  final suggestor = WorkoutSuggestor();
  var workouts = <Workout>[];
  var myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Main Window",
            style: TextStyle(fontSize: 16),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
              itemCount: workouts.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.task),
                        title: Text(workouts[index].title),
                        subtitle: Text(workouts[index].contents.toString()),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          getTextButton('Edit list', index, editWorkout),
                          const SizedBox(width: 8),
                          getTextButton('Run', index, editWorkout),
                          const SizedBox(width: 8),
                          getTextButton('Delete', index, deleteWorkout),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                );
                // Text(vehicles[index].toString());
              },
            )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                child: const Text('Add Workout'),
                onPressed: () async {
                  Workout? workout = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkoutPlanner(
                        suggestor: suggestor,
                      ),
                    ),
                  );
                  setState(() {
                    workouts.add(workout!);
                  });
                },
              ),
            )
          ],
        ));
  }

  void addNewExercise() {
    setState(() {
      Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
        var textFields = [
          TextField(
            controller: myController,
          )
        ];

        return Scaffold(
          appBar: AppBar(
            title:
                const Text("Add new Exercise", style: TextStyle(fontSize: 16)),
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
                child: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () => setState(() => textFields.add(TextField(
                        controller: myController,
                      ))),
                ),
              )
            ],
          ),
        );
      }));
    });
  }

  Widget itemBuilder(BuildContext context, int idx) {
    return ExpansionTile(
      title: const Text('Exercise list'),
      children: <Widget>[Column(children: _buildContent(workouts[idx]))],
    );
  }

  _buildContent(Workout vehicle) {
    List<Widget> columnContent = <Widget>[];
    for (String content in vehicle.contents) {
      columnContent.add(ListTile(
        title: Text(content, style: const TextStyle(fontSize: 18)),
        leading: Icon(vehicle.icon),
      ));
    }
    return columnContent;
  }

  Widget getTextButton(String buttonText, int index, Function(int) callback) {
    return TextButton(
        child: Text(buttonText),
        onPressed: () async {
          callback(index);
        });
  }

  editWorkout(index) async {
    Workout? workout = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkoutUpdater(
            workout: workouts[index],
            suggestor: suggestor,
          ),
        ));
    if (workout != null) {
      setState(() {
        workouts[index] = workout;
      });
    }
  }

  deleteWorkout(index) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Text("Deleting workout ${workouts[index].title}. "
                                "Are you sure?"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            // Snap back;
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: const Text("Delete"),
                          onPressed: () {
                            setState(() {
                              workouts.removeAt(index);
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
