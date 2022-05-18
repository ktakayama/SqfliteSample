
import 'package:sqflite_sample/database/dao.dart';
import 'package:sqflite_sample/database/database_repository.dart';

class Cat implements Model {
  @override
  int id;
  String name;
  int age;

  Cat(
    this.id,
    this.name,
    this.age,
  );
}

class CatDao implements Dao<Cat> {
  @override
  var columnId = 'id';
  final _columnName = 'name';
  final _columnAge = 'age';

  @override
  var tableName = (Cat).toString().toLowerCase();

  @override
  Cat fromMap(Map<dynamic, dynamic> query) {
    var cat = Cat(query[columnId], query[_columnName], query[_columnAge]);
    return cat;
  }

  @override
  Map<String, dynamic> toMap(Cat object) {
    return <String, dynamic>{
      _columnName: object.name,
      _columnAge: object.age,
    };
  }

  @override
  List<Cat> fromList(List<Map<dynamic, dynamic>> query) {
    var cats = <Cat>[];
    for (Map<dynamic, dynamic> map in query) {
      cats.add(fromMap(map));
    }
    return cats;
  }
}

class CatRepository extends DatabaseRepository<CatDao, Cat> {
  CatRepository(databaseProvider) : super(CatDao(), databaseProvider);
}
