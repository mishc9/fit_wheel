import 'package:fit_wheel/main/workoutRepr.dart';
import 'package:fit_wheel/planner/suggestor.dart';
import 'package:fit_wheel/workout.dart';
import 'package:flutter/material.dart';

class WorkoutListView extends StatefulWidget {
  final List<Workout> workouts;
  final WorkoutSuggestor suggestor;

  WorkoutListView({
    Key? key,
    required this.workouts,
    required this.suggestor,
  }) : super(key: key);

  @override
  WorkoutListViewState createState() => WorkoutListViewState();
}

class WorkoutListViewState extends State<WorkoutListView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
        child: ListView.builder(
      itemCount: widget.workouts.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.task),
                title: Text(widget.workouts[index].title),
                subtitle: Text(widget.workouts[index].contents.toString()),
              ),
              WorkoutReprWidget(
                  workouts: widget.workouts,
                  suggestor: widget.suggestor,
                  index: index),
            ],
          ),
        );
        // Text(vehicles[index].toString());
      },
    ));
  }
}
