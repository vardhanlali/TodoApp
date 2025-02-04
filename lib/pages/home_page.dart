import 'package:flutter/material.dart';
import 'package:appss/utils/todo_list.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _controller = TextEditingController();
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

  void saveNewTask() {
  setState(() {
    toDoList.add([_controller.text, false]);
    _controller.clear();
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0), // To add some bottom space for the FAB
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Add a new todo item',
                    filled: true,
                    fillColor: Colors.deepPurple.shade100,
                    enabledBorder: OutlineInputBorder(
                      borderSide:  BorderSide(
                          color: Colors.white
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepPurple.shade200
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                ),
              ),
            ),
            FloatingActionButton(
              onPressed: saveNewTask,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }


}
