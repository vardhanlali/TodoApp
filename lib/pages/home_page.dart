import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(title: Text(
          'Simple Todo',
      ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

    );
  }
}