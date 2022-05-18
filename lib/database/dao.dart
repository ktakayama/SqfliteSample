abstract class Dao<T extends Model> {
  var columnId = 'id';
  var tableName = 'name';
  List<T> fromList(List<Map<dynamic, dynamic>> query);
  T fromMap(Map<String, dynamic> query);
  Map<String, dynamic> toMap(T object);
}

abstract class Model {
  var id = 0;
}
