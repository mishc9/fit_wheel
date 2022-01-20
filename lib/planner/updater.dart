import 'package:fit_wheel/planner/suggestor.dart';
import 'package:fit_wheel/workout.dart';
import 'package:flutter/material.dart';

import 'abc.dart';

class WorkoutUpdater extends StatefulList {
  final Workout workout;
  final WorkoutSuggestor suggestor;

  const WorkoutUpdater({
    Key? key,
    required this.suggestor,
    required this.workout,
  }) : super(key: key);

  @override
  _ELState createState() => _ELState();
}

class _ELState extends ListState<WorkoutUpdater> {
  @override
  void initState() {
    super.initState();
    final controller = TextEditingController(text: widget.workout.title);
    myController.add(controller);
    textFields.add(initCard('New Exercise', controller, newCard: true));
    for (int i = 0; i < widget.workout.contents.length; i++) {
      final controller =
          TextEditingController(text: widget.workout.contents[i]);
      myController.add(controller);
      textFields.add(initCard('Exercise Name', controller));
    }
  }

  Card initCard(String fieldName, TextEditingController controller,
      {bool newCard = false}) {
    return Card(
        child: newCard
            ? getNewColumn(controller, fieldName)
            : getDropdownColumn(controller, fieldName, widget.suggestor)
        // : getItemColumn(controller, fieldName),
        );
  }
}
