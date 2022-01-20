class WorkoutSuggestor {
  var exercises = <String>[];

  List<String> getSuggestions(String pattern) {
    return exercises.where((element) => element.startsWith(pattern)).toList();
  }

  void add(String name) {
    if (!exercises.contains(name)) {
      exercises.add(name);
    }
  }
}

