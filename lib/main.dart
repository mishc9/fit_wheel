// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:fit_wheel/workout.dart';
import 'package:flutter/material.dart';

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
                          TextButton(
                            child: const Text('Edit list'),
                            onPressed: () async {
                              Workout? vehicle = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditList(workout: workouts[index]),
                                ),
                              );
                              if (vehicle != null) {
                                setState(() {
                                  workouts[index] = vehicle;
                                });
                              }
                            },
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            child: const Text('Run'),
                            onPressed: () async {
                              Workout? workout = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditList(workout: workouts[index]),
                                  ));
                              if (workout != null) {
                                setState(() {
                                  workouts[index] = workout;
                                });
                              }
                            },
                          ),
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
                      builder: (context) => const WorkoutList(),
                    ),
                  );
                  if (workout != null) {
                    setState(() {
                      workouts.add(workout);
                    });
                  }
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
}
