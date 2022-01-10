import 'dart:async';

import 'package:fit_wheel/db/database.dart';
import 'package:fit_wheel/model/entry.dart';
import 'package:sembast/sembast.dart';

class EntriesDao {
  static const String entriesFolderName = "Entries";
  final _entriesFolder = intMapStoreFactory.store(entriesFolderName);

  Future<Database> get db async => await AppDatabase.instance.database;

  Future insertEntries(Entry entry) async {
    print("Add entry ${entry.toString()}");
    await _entriesFolder.add(await db, entry.toJson());
  }

  Future updateEntries(Entry entry) async {
    final finder = Finder(filter: Filter.byKey(entry.entryName));
    await _entriesFolder.update(await db, entry.toJson(), finder: finder);
  }

  Future<List<Entry>> getEntriesByName(String name) async {
    print("Received a name ${name}");
    final finder = Finder(filter: Filter.byKey(name));
    final snapshotValue = await _entriesFolder.find(await db, finder: finder);
    return snapshotValue.map((snapshot) {
      final entry = Entry.fromJson(snapshot.value);
      return entry;
    }).toList();
  }

  Future delete(Entry entry) async {
    final finder = Finder(filter: Filter.byKey(entry.entryName));
    await _entriesFolder.delete(await db, finder: finder);
  }

  Future<List<Entry>> getAllEntries() async {
    final snapshotValue = await _entriesFolder.find(await db);
    return snapshotValue.map((snapshot) {
      final entry = Entry.fromJson(snapshot.value);
      return entry;
    }).toList();
  }
}
