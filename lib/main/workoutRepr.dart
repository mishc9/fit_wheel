import 'package:fit_wheel/planner/suggestor.dart';
import 'package:fit_wheel/planner/updater.dart';
import 'package:fit_wheel/workout.dart';
import 'package:flutter/material.dart';

import 'deleter.dart';

class WorkoutReprWidget extends StatefulWidget {
  final List<Workout> workouts;
  final WorkoutSuggestor suggestor;
  final int index;

  WorkoutReprWidget(
      {Key? key,
      required this.workouts,
      required this.suggestor,
      required this.index})
      : super(key: key);

  @override
  WorkoutReprWidgetState createState() => WorkoutReprWidgetState();
}

class WorkoutReprWidgetState extends State<WorkoutReprWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        getTextButton('Edit list', editWorkout),
        const SizedBox(width: 8),
        getTextButton('Run', editWorkout),
        const SizedBox(width: 8),
        getTextButton('Delete', deleteWorkout),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget getTextButton(String buttonText, Function() callback) {
    return TextButton(
        child: Text(buttonText),
        onPressed: () async {
          callback();
        });
  }

  editWorkout() async {
    Workout? workout = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkoutUpdater(
            workout: widget.workouts[widget.index],
            suggestor: widget.suggestor,
          ),
        ));
    if (workout != null) {
      setState(() {
        widget.workouts[widget.index] = workout;
      });
    }
  }

  deleteWorkout() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ExerciseDeleter(
              workouts: widget.workouts, index: widget.index);
        });
  }
}
