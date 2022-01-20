import 'package:fit_wheel/main/workoutList.dart';
import 'package:fit_wheel/planner/suggestor.dart';
import 'package:fit_wheel/workout.dart';
import 'package:flutter/material.dart';

import 'addWorkout.dart';

class MainPage extends StatefulWidget {
  final WorkoutSuggestor suggestor;
  final List<Workout> workouts;

  MainPage({Key? key, required this.workouts, required this.suggestor})
      : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        WorkoutListView(workouts: widget.workouts, suggestor: widget.suggestor),
        AddWorkout(workouts: widget.workouts, suggestor: widget.suggestor),
      ],
    );
  }
}
