import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final _instance = DatabaseProvider._privateConstructor();
  static DatabaseProvider shared = _instance;

  Database? _db;

  DatabaseProvider._privateConstructor();

  Future<Database> db() async {
    return _db ??= await openDatabase(
      'doggie_database.db',
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      version: 1,
    );
  }
}
