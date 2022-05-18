import 'package:sqflite_sample/database/dao.dart';
import 'package:sqflite_sample/database_provider.dart';

class DatabaseRepository<T extends Dao<Y>, Y extends Model> {
  final T dao;

  DatabaseProvider databaseProvider;

  DatabaseRepository(this.dao, this.databaseProvider);

  Future<Y> insert(Y object) async {
    final db = await databaseProvider.db();
    object.id = await db.insert(dao.tableName, dao.toMap(object));
    return object;
  }

  Future<Y> delete(Y object) async {
    final db = await databaseProvider.db();
    await db.delete(dao.tableName,
        where: dao.columnId + " = ?", whereArgs: [object.id]);
    return object;
  }

  Future<Y> update(Y object) async {
    final db = await databaseProvider.db();
    await db.update(dao.tableName, dao.toMap(object),
        where: dao.columnId + " = ?", whereArgs: [object.id]);
    return object;
  }

  Future<List<Y>> all() async {
    final db = await databaseProvider.db();
    List<Map> maps = await db.query(dao.tableName);
    return dao.fromList(maps);
  }
}
