import 'package:flutter/material.dart';
import 'package:hive_crud/models/task_model.dart';
import 'package:hive_crud/task_editor.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile(this.task, this.index, {Key? key}) : super(key: key);
  final Task task;
  final int index;
  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
          color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                widget.task.title!,
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              )),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskEditor(
                          task: widget.task,
                        ),
                      ));
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: () {
                  widget.task.delete();
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.black87,
            height: 20.0,
            thickness: 1.0,
          ),
          Text(
            widget.task.note!,
            style: const TextStyle(fontSize: 16.0),
          )
        ],
      ),
    );
  }
}
