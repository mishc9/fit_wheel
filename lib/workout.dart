import 'package:flutter/material.dart';

class Workout {
  final String title;
  List<String> contents = <String>[];
  final IconData icon;

  Workout(this.title, this.contents, this.icon);

  @override
  String toString() {
    // TODO: implement toString
    return "Exercise Type $title: $contents";
  }
}
