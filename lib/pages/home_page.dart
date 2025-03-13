import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appss/utils/todo_list.dart';
import 'package:appss/services/auth_service.dart';
import 'package:appss/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  List<Map<String, dynamic>> toDoList = [];

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      _loadTasks();
    }
  }

  // Load tasks from Firestore with priority ordering
 void _loadTasks() async {
  if (_user == null) return;

  final snapshot = await _firestore
      .collection('users')
      .doc(_user!.uid)
      .collection('tasks')
      .orderBy('priority', descending: false) // Prioritize tasks correctly
      .get();

  setState(() {
    toDoList = snapshot.docs
        .map((doc) => {
              'id': doc.id,
              'task': doc['task'],
              'completed': doc['completed'],
              'priority': doc.data().containsKey('priority') ? doc['priority'] : 0, // Default if missing
            })
        .toList();
  });
}



  // Save new task to Firestore with default priority
  void saveNewTask() async {
  if (_controller.text.trim().isEmpty || _user == null) return;

  DocumentReference docRef = await _firestore
      .collection('users')
      .doc(_user!.uid)
      .collection('tasks')
      .add({
    'task': _controller.text.trim(),
    'completed': false,
    'priority': toDoList.length, // Ensure priority is stored
  });

  setState(() {
    toDoList.add({
      'id': docRef.id,
      'task': _controller.text.trim(),
      'completed': false,
      'priority': toDoList.length,
    });
    _controller.clear();
  });
}


  // Update task completion status
  void checkBoxChanged(int index, bool? value) async {
    if (_user == null) return;
    await _firestore
        .collection('users')
        .doc(_user!.uid)
        .collection('tasks')
        .doc(toDoList[index]['id'])
        .update({'completed': value ?? false});

    setState(() {
      toDoList[index]['completed'] = value ?? false;
    });
  }

  // Delete task
  void deleteTask(int index) async {
    if (_user == null) return;
    await _firestore
        .collection('users')
        .doc(_user!.uid)
        .collection('tasks')
        .doc(toDoList[index]['id'])
        .delete();

    setState(() {
      toDoList.removeAt(index);
    });
  }

  // Handle reordering of tasks
  void _reorderTasks(int oldIndex, int newIndex) async {
    if (_user == null) return;

    setState(() {
      if (newIndex > oldIndex) newIndex--; // Adjust index if moved down
      final item = toDoList.removeAt(oldIndex);
      toDoList.insert(newIndex, item);
    });

    // Update Firestore with new priorities
    for (int i = 0; i < toDoList.length; i++) {
      await _firestore
          .collection('users')
          .doc(_user!.uid)
          .collection('tasks')
          .doc(toDoList[i]['id'])
          .update({'priority': i});
    }
  }

  // Sign out user
  void signOut() async {
    await AuthService().signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: const Text('Simple Todo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: signOut,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ReorderableListView(
              onReorder: _reorderTasks,
              children: [
                for (int index = 0; index < toDoList.length; index++)
                  Dismissible(
                    key: ValueKey(toDoList[index]['id']),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) => deleteTask(index),
                    child: ListTile(
                      title: TodoList(
                        taskName: toDoList[index]['task'],
                        taskCompleted: toDoList[index]['completed'],
                        onChanged: (value) => checkBoxChanged(index, value),
                        deleteFunction: (context) => deleteTask(index),
                      ),
                      trailing: const Icon(Icons.drag_handle),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0, left: 10, right: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Add a new todo item',
                      filled: true,
                      fillColor: Colors.deepPurple.shade100,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: saveNewTask,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
