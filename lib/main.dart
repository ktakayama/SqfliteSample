import 'package:flutter/material.dart';
import 'package:sqflite_sample/database/database_provider.dart';
import 'package:sqflite_sample/model/dog.dart';
import 'package:sqflite_sample/model/cat.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _dogs = <Dog>[];
  var _cats = <Cat>[];
  final _dogRepo = DogRepository(DatabaseProvider.shared);
  final _catRepo = CatRepository(DatabaseProvider.shared);

  _addDog() {
    var rand = math.Random();
    var id = _dogs.length + 1;
    var dog = Dog(id, 'Dog Name: ${rand.nextInt(100)}', rand.nextInt(100));
    _dogRepo.insert(dog).then((value) {
      print('Insert dog ${value}');
      _updateDogList();
    });

    var cat = Cat(id, 'Cat Name: ${rand.nextInt(100)}', rand.nextInt(100));
    _catRepo.insert(cat).then((value) {
      print('Insert cat ${value}');
      _updateCatList();
    });

    DatabaseProvider.shared.db().then((db) {
      print(db.path);
    });
  }

  _updateDogList() {
    _dogRepo.all().then((value) {
      setState(() {
        _dogs = value.reversed.toList();
      });
    });
  }

  _updateCatList() {
    _catRepo.all().then((value) {
      setState(() {
        _cats = value.reversed.toList();
      });
    });
  }

  ListTile _dogTile(Dog dog) {
    return ListTile(title: Text(dog.name), subtitle: Text('age: ${dog.age}'));
  }

  ListTile _catTile(Cat cat) {
    return ListTile(title: Text(cat.name), subtitle: Text('age: ${cat.age}'));
  }

  @override
  void initState() {
    super.initState();
    _updateDogList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          SizedBox(
              width: 150,
              child: ListView.builder(
                  itemBuilder: (context, i) => _dogTile(_dogs[i]),
                  itemCount: _dogs.length)),
          SizedBox(
              width: 150,
              child: ListView.builder(
                  itemBuilder: (context, i) => _catTile(_cats[i]),
                  itemCount: _cats.length)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDog,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
