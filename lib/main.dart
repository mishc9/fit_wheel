// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:fit_wheel/workout.dart';
import 'package:flutter/material.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';


import 'lists.dart';

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

  final service = WorkoutService();
  var workouts = <Workout>[];
  var myController = TextEditingController();

  Widget getTextButton(String buttonText, int index, Function(int) callback) {
    return TextButton(
        child: Text(buttonText),
        onPressed: () async {
          callback(index);
        });
  }

  updateWorkout(index) async {
    Workout? workout = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditList(
            workout: workouts[index], service: service,),
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
                        child: Text(
                            "Deleting workout ${workouts[index].title}. "
                            "Are you sure?"
                        ),
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
                          getTextButton('Edit list', index, updateWorkout),
                          const SizedBox(width: 8),
                          getTextButton('Run', index, updateWorkout),
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
                      builder: (context) => WorkoutList(service: service,),
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

  _deleteWorkout(index) async {
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
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: const Text("Submitß"),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                            }
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
