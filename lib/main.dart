import 'package:flutter/material.dart';
import 'package:hive_crud/home_page.dart';
import 'package:hive_crud/models/task_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box box;
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  box = await Hive.openBox<Task>("tasks");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
