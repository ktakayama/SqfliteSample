import 'package:sqflite_sample/database/dao.dart';

class Dog implements Model {
  @override
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
  @override
  var tableName = 'dogs';
  @override
  var columnId = 'id';
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
