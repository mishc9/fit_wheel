import 'package:flutter/material.dart';

class Workout extends StatefulWidget {
  final String title;
  List<String> contents = <String>[];
  final IconData icon;

  Workout(
      {Key? key,
      required this.title,
      required this.contents,
      required this.icon})
      : super(key: key);

  @override
  WorkoutState createState() => WorkoutState();
}

class WorkoutState extends State<Workout> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.task),
      title: Text(widget.title),
      subtitle: Text(widget.contents.toString()),
    );
  }
}

abstract class Exercise {
  // An abstract class or what? :thinking:
  String? name;
}

class PresetFactory {
  List showPresets() {
    return <int>[];
  }
}

abstract class _Exercise extends StatefulWidget {
  String? name;
  int? duration;
  int? restBreakDuration;

  _Exercise({Key? key}) : super(key: key);

  @override
  _ExerciseState createState() => _ExerciseState();

  void run() {}
}

class _ExerciseState extends State {
  @override
  Widget build(BuildContext context) {
    return Column();
  }
}

class ExerciseFiller extends StatefulWidget {
  ExerciseFiller({Key? key}) : super(key: key);

  @override
  ExerciseFillerState createState() => ExerciseFillerState();
}

class ExerciseFillerState extends State {
  @override
  Widget build(BuildContext context) {
    return Column();
  }
}

class ExercisePreset {
  // Should be a 'wrapper' for an exercise?
  ExercisePreset.wrapExercise(Exercise exercise) {}
}
