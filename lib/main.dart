import 'package:fit_wheel/planner/suggestor.dart';
import 'package:fit_wheel/workout.dart';
import 'package:flutter/material.dart';

import 'main/mainPage.dart';

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
        body: MainPage(
          workouts: workouts,
          suggestor: suggestor,
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
