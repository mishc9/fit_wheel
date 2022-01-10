import 'package:english_words/english_words.dart';
import 'package:fit_wheel/dao/entries_dao.dart';
import 'package:fit_wheel/model/entry.dart';

String wordPairToString(WordPair wordPair) {
  return "${wordPair.first}:${wordPair.second}";
}

WordPair stringToWordPair(String string) {
  final split = string.split(":");
  return WordPair(split.elementAt(0), split.elementAt(1));
}

WordPair entryToWordPair(Entry entry) {
  return stringToWordPair(entry.entryName);
}

class EntryList {
  // Todo: make a template class for any kind of entry/local repr
  Set<WordPair> liked = <WordPair>{};
  List<WordPair> generated = <WordPair>[];
  final EntriesDao _entriesDao = EntriesDao();

  EntryList() {
    final _entriesDao = EntriesDao();
    _entriesDao.getAllEntries().then((value) {
      generated = value.map((entry) => entryToWordPair(entry)).toList();
      liked = value
          .where((entry) => entry.saved)
          .map((entry) => entryToWordPair(entry))
          .toSet();
    });
  }

  Future _addAll(Iterable<WordPair> wordPairs) async {
    print("List length ${wordPairs.length}");
    var stream = Stream.fromIterable(wordPairs);
    await for (var wordPair in stream) {
      _entriesDao.insertEntries(
          Entry(
            saved: false,
            entryName: wordPairToString(wordPair),
          )
      );
    }
  }

  void addAll(Iterable<WordPair> wordPairs) {
    print("Got WordPairs ${wordPairs}");
    _addAll(wordPairs).then((pairs) => print(pairs));
    generated.addAll(wordPairs);
    _entriesDao
        .getAllEntries()
        .then((value) => print("Contains value ${value}"));
  }

  void like(WordPair wordPair) {
    _entriesDao
        .getEntriesByName(wordPairToString(wordPair))
        .then((_savedPair) => _savedPair.isNotEmpty ? _like(_savedPair) : null);
  }

  void _like(List<Entry> listEntry) {
    print("Got entry: ${listEntry}");
    for (int index = 0; index < listEntry.length; index++) {
      final entry = listEntry.elementAt(index);
      if (!liked.contains(entryToWordPair(entry))) {
        liked.add(entryToWordPair(entry));
        entry.saved = true;
        _entriesDao.updateEntries(entry);
      }
    }
  }

  void dislike(WordPair wordPair) {
    _entriesDao.getEntriesByName(wordPairToString(wordPair)).then(
        (_savedPair) => _savedPair.isNotEmpty ? _dislike(_savedPair) : null);
  }

  void _dislike(List<Entry> listEntry) {
    for (int index = 0; index < listEntry.length; index++) {
      final entry = listEntry.elementAt(index);
      if (liked.contains(entryToWordPair(entry))) {
        liked.remove(entryToWordPair(entry));
        entry.saved = false;
        _entriesDao.updateEntries(entry);
      }
    }
  }

  bool pairIsLiked(WordPair wordPair) {
    return liked.contains(wordPair);
  }
}
