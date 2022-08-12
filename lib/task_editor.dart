import 'package:flutter/material.dart';
import 'package:hive_crud/home_page.dart';
import 'package:hive_crud/models/task_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskEditor extends StatefulWidget {
  const TaskEditor({this.task, Key? key}) : super(key: key);
  final Task? task;

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _taskTitle = TextEditingController(
        text: widget.task == null ? null : widget.task!.title!);
    TextEditingController _taskNote = TextEditingController(
        text: widget.task == null ? null : widget.task!.note!);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.task == null ? "Add a new Task" : "Upgrade your Task",
          style: const TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Task Title",
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextField(
              controller: _taskTitle,
              decoration: InputDecoration(
                fillColor: Colors.blue.shade100.withAlpha(75),
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0)),
                hintText: "Your Task",
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            const Text(
              "Your Task Note",
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 25,
              controller: _taskNote,
              decoration: InputDecoration(
                fillColor: Colors.blue.shade100.withAlpha(75),
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0)),
                hintText: "Write anything about your task",
              ),
            ),
            Expanded(
                child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 60.0,
                child: RawMaterialButton(
                  onPressed: () async {
                    var newTask = Task(
                      title: _taskTitle.text,
                      note: _taskNote.text,
                      creation_data: DateTime.now(),
                      done: false,
                    );
                    Box<Task> taskBox = Hive.box<Task>("tasks");
                    if (widget.task != null) {
                      widget.task!.title = newTask.title;
                      widget.task!.note = newTask.note;
                      widget.task!.save();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const HomePage())));
                    } else {
                      await taskBox.add(newTask);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const HomePage())));
                    }
                  },
                  fillColor: Colors.blueAccent.shade700,
                  child: Text(
                    widget.task == null ? "Add new Task" : "Update Task",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.8,
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
