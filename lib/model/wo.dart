import 'dart:async';
import 'package:flutter/services.dart';

const String restBreakName = "Rest break";

class Exercise {
  String name = "";
  int totalDuration = 0;
  int endTimer = 0;
  int restBreakTime = 0;

  Exercise(String name, int totalDuration, int endTimer, int restBreakTime) {
    name = name;
    totalDuration = totalDuration;
    endTimer = endTimer;
    restBreakTime = restBreakTime;
  }

  Exercise.halfMinute(String name)
      : name = name,
        totalDuration = 30,
        endTimer = 5,
        restBreakTime = 0;

  Exercise.minute(String name)
      : name = name,
        totalDuration = 60,
        endTimer = 5,
        restBreakTime = 0;

  Exercise.minuteWithRest(String name)
      : name = name,
        totalDuration = 60,
        endTimer = 5,
        restBreakTime = 15;

  Exercise.restBreak()
      : name = restBreakName,
        totalDuration = 30,
        endTimer = 5,
        restBreakTime = 30;
}


class WorkOut {
  List<Exercise> exercises = <Exercise>[];

  Future addExercise(Exercise exercise) async {
    exercises.add(exercise);
  }
}