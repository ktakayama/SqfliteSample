import 'package:sqflite_sample/model/dao.dart';
import 'package:sqflite_sample/database_provider.dart';

class Dog {
  int id;
  String name;
  int age;

  Dog(
    this.id,
    this.name,
    this.age,
  );
}

class DogDao implements Dao<Dog> {
  final tableName = 'dogs';
  final columnId = 'id';
  final _columnName = 'name';
  final _columnAge = 'age';

  @override
  Dog fromMap(Map<dynamic, dynamic> query) {
    var dog = Dog(query[columnId], query[_columnName], query[_columnAge]);
    return dog;
  }

  @override
  Map<String, dynamic> toMap(Dog object) {
    return <String, dynamic>{
      _columnName: object.name,
      _columnAge: object.age,
    };
  }

  @override
  List<Dog> fromList(List<Map<dynamic, dynamic>> query) {
    var dogs = <Dog>[];
    for (Map<dynamic, dynamic> map in query) {
      dogs.add(fromMap(map));
    }
    return dogs;
  }
}

class DogsRepository {
  final dao = DogDao();

  DatabaseProvider databaseProvider;

  DogsRepository(this.databaseProvider);

  Future<Dog> insert(Dog dog) async {
    final db = await databaseProvider.db();
    dog.id = await db.insert(dao.tableName, dao.toMap(dog));
    return dog;
  }

  Future<Dog> delete(Dog dog) async {
    final db = await databaseProvider.db();
    await db.delete(dao.tableName,
        where: dao.columnId + " = ?", whereArgs: [dog.id]);
    return dog;
  }

  Future<Dog> update(Dog dog) async {
    final db = await databaseProvider.db();
    await db.update(dao.tableName, dao.toMap(dog),
        where: dao.columnId + " = ?", whereArgs: [dog.id]);
    return dog;
  }

  Future<List<Dog>> getDogs() async {
    final db = await databaseProvider.db();
    List<Map> maps = await db.query(dao.tableName);
    return dao.fromList(maps);
  }
}
