// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

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

class EditList extends StatefulWidget {
  final Vehicle? vehicles;

  const EditList({Key? key, this.vehicles}) : super(key: key);

  @override
  _ELState createState() => _ELState();
}

class _ELState extends State<EditList> {
  var textFields = <Card>[];
  var myController = <TextEditingController>[];

  @override
  void initState() {
    super.initState();
    final controller = TextEditingController(text: widget.vehicles!.title);
    myController.add(controller);
    textFields.add(initCard('New Exercise', controller, newCard: true));
    for (int i = 0; i < widget.vehicles!.contents.length; i++) {
      final controller =
          TextEditingController(text: widget.vehicles!.contents[i]);
      myController.add(controller);
      textFields.add(initCard('Exercise Name', controller));
    }
  }

  Card initCard(
      String fieldName,
      TextEditingController controller,
      {bool newCard = false}) {
    return Card(
      child: newCard
          ? Column(
              children: <Widget>[
                const Text('New Exercise'),
                TextField(
                    controller: controller,
                    decoration: InputDecoration(labelText: fieldName)),
              ],
            )
          : Column(
              children: <Widget>[
                TextField(
                    controller: controller,
                    decoration: InputDecoration(labelText: fieldName)),
              ],
            ),
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
                  setState(() => textFields.add(createCard('Exercise Name'))),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.done), onPressed: _onDone),
    );
  }

  _onDone() {
    if (myController.isEmpty) {
      return;
    }
    var vehicleName = myController[0].text;
    if (myController.length == 1) {
      Navigator.pop(context, Vehicle(vehicleName, [], Icons.add));
      return;
    }
    List<String> vehicleNames = <String>[];
    for (int i = 1; i < textFields.length; i++) {
      var name = myController[i].text;
      vehicleNames.add(name);
    }
    Navigator.pop(context, Vehicle(vehicleName, vehicleNames, Icons.add));
  }

  Card createCard(String fieldName, {bool newCard = false}) {
    var controller = TextEditingController();
    myController.add(controller);
    return Card(
      child: newCard
          ? Column(
        children: <Widget>[
          const Text('New Exercise Type'),
          TextField(
              controller: controller,
              decoration: InputDecoration(labelText: fieldName)),
        ],
      )
          : Column(
        children: <Widget>[
          TextField(
              controller: controller,
              decoration: InputDecoration(labelText: fieldName)),
        ],
      ),
    );
  }
}

class VehicleList extends StatefulWidget {
  const VehicleList({Key? key}) : super(key: key);

  @override
  _VLState createState() => _VLState();
}

class _VLState extends State<VehicleList> {
  var textFields = <Card>[];
  var myController = <TextEditingController>[];

  Card createCard(String fieldName, {bool newCard = false}) {
    var controller = TextEditingController();
    myController.add(controller);
    return Card(
      child: newCard
          ? Column(
              children: <Widget>[
                const Text('New Exercise Type'),
                TextField(
                    controller: controller,
                    decoration: InputDecoration(labelText: fieldName)),
              ],
            )
          : Column(
              children: <Widget>[
                TextField(
                    controller: controller,
                    decoration: InputDecoration(labelText: fieldName)),
              ],
            ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textFields.add(createCard('New Exercise Type', newCard: true));
  }

  _onDone() {
    if (myController.isEmpty) {
      return;
    }
    var vehicleName = myController[0].text;
    if (myController.length == 1) {
      Navigator.pop(context, Vehicle(vehicleName, [], Icons.add));
      return;
    }
    List<String> vehicleNames = <String>[];
    for (int i = 1; i < textFields.length; i++) {
      var name = myController[i].text;
      vehicleNames.add(name);
    }
    Navigator.pop(context, Vehicle(vehicleName, vehicleNames, Icons.add));
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

class _MyAppState extends State<MyApp> {
  var vehicles = <Vehicle>[];
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
              itemCount: vehicles.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.task),
                        title: Text(vehicles[index].title),
                        subtitle: Text(vehicles[index].contents.toString()),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            child: const Text('Edit list'),
                            onPressed: () async {
                              Vehicle? vehicle = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditList(vehicles: vehicles[index]),
                                ),
                              );
                              if (vehicle != null) {
                                setState(() {
                                  vehicles[index] = vehicle;
                                });
                              }
                            },
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            child: const Text('Run'),
                            onPressed: () async {
                              Vehicle? vehicle = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditList(vehicles: vehicles[index]),
                                  ));
                              if (vehicle != null) {
                                setState(() {
                                  vehicles[index] = vehicle;
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
                child: const Text('Add Exercise'),
                onPressed: () async {
                  Vehicle? vehicle = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VehicleList(),
                    ),
                  );
                  if (vehicle != null) {
                    setState(() {
                      vehicles.add(vehicle);
                    });
                  }
                },
              ),
            )
          ],
        ));
  }

  void addNewVehicle() {
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
      children: <Widget>[Column(children: _buildContent(vehicles[idx]))],
    );
  }

  _buildContent(Vehicle vehicle) {
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

class Vehicle {
  final String title;
  List<String> contents = <String>[];
  final IconData icon;

  Vehicle(this.title, this.contents, this.icon);

  @override
  String toString() {
    // TODO: implement toString
    return "Exercise Type $title: $contents";
  }
}
