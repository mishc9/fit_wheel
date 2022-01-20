import 'package:fit_wheel/workout.dart';
import 'package:flutter/material.dart';

class ExerciseDeleter extends StatefulWidget {
  // Todo: is providing index really worth it, or there exist a better way?
  final List<Workout> workouts;
  final int index;
  final Function() notifyParent;

  ExerciseDeleter({
    Key? key,
    required this.workouts,
    required this.index,
    required this.notifyParent,
  }) : super(key: key);

  @override
  ExerciseDeleterState createState() => ExerciseDeleterState();
}

class ExerciseDeleterState extends State<ExerciseDeleter> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      content: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            right: -40.0,
            top: -40.0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const CircleAvatar(
                child: Icon(Icons.close),
                backgroundColor: Colors.red,
              ),
            ),
          ),
          Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Deleting workout ${widget.workouts[widget.index].title}. "
                      "Are you sure?"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      // Snap back;
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text("Delete"),
                    onPressed: () {
                      setState(() {
                        widget.workouts.removeAt(widget.index);
                        widget.notifyParent();
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}
