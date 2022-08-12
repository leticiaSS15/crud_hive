import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:hive_crud/models/task_model.dart';
import 'package:hive_crud/task_editor.dart';
import 'package:hive_crud/widgets/custom_list_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: const Text(
          'My Tasks App',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: Hive.box<Task>("tasks").listenable(),
        builder: (context, box, _) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Today Tasks: ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  formatDate(DateTime.now(), [d, ", ", M, ", ", yyyy]),
                  style: const TextStyle(color: Colors.grey, fontSize: 18),
                ),
                const Divider(
                  height: 40,
                  thickness: 1.0,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: box.values.length,
                        itemBuilder: (context, index) {
                          Task currentTask = box.getAt(index)!;
                          return CustomListTile(currentTask, index);
                        }))
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskEditor(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
