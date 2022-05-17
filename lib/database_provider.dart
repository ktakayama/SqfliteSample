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

class DatabaseProvider2 {
  static final _instance = DatabaseProvider2._privateConstructor();
  static DatabaseProvider2 shared = _instance;

  late Database db;

  DatabaseProvider2._privateConstructor() {
    _init();
  }

  _init() async {
    db = await openDatabase(
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
