import 'package:fit_wheel/planner/planner.dart';
import 'package:fit_wheel/planner/suggestor.dart';
import 'package:fit_wheel/workout.dart';
import 'package:flutter/material.dart';


class AddWorkout extends StatefulWidget {
  final List<Workout> workouts;
  final WorkoutSuggestor suggestor;

  AddWorkout({
    Key? key,
    required this.workouts,
    required this.suggestor,
  }) : super(key: key);

  @override
  AddWorkoutState createState() => AddWorkoutState();
}

class AddWorkoutState extends State<AddWorkout> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        child: const Text('Add Workout'),
        onPressed: () async {
          Workout? workout = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkoutPlanner(
                suggestor: widget.suggestor,
              ),
            ),
          );
          setState(() {
            widget.workouts.add(workout!);
          });
        },
      ),
    );
  }
}
