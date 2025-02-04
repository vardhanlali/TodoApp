import 'package:appss/utils/todo_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List toDoList = [
    ['Learn Flutter Basics', false],
    ['Build ToDo App', false],
    ['Learn Concepts while coding', false],

  ];

  void checkBoxChanged(int index, bool? value) {
    setState(() {
      toDoList[index][1] = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: const Text('Simple Todo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (BuildContext context, index) {
          return TodoList(
            taskName: toDoList[index][0], // Passing the task name
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkBoxChanged(index, value), // Pass value to checkBoxChanged
          );
        },
      ),
    );
  }
}
