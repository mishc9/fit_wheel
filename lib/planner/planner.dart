import 'package:fit_wheel/planner/suggestor.dart';
import 'package:fit_wheel/workout.dart';
import 'package:flutter/material.dart';

import 'abc.dart';

class WorkoutPlanner extends StatefulList {
  final WorkoutSuggestor suggestor;

  const WorkoutPlanner({
    Key? key,
    required this.suggestor,
  }) : super(key: key);

  @override
  _PlannerState createState() => _PlannerState();
}


class _PlannerState extends ListState<WorkoutPlanner> {
  @override
  void initState() {
    super.initState();
    textFields.add(createCard('New Exercise Type', newCard: true));
  }
}
