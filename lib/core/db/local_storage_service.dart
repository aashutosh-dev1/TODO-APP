import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class LocalStorageService {
  /// initialize db
  Future<Database> initializeDB();
}

class LocalStorageServiceImpl extends LocalStorageService {
  @override
  Future<Database> initializeDB() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'task.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, label TEXT, description TEXT, priority INTEGER, completed INTEGER)',
        );
      },
      version: 1,
    );

    return database;
  }
}
