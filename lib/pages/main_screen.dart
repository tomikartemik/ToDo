import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(title: Text('Main screen'), centerTitle: true, backgroundColor: Colors.deepPurple,),
      body: Column(
        children: [
          Text('Main screen', style: TextStyle(color: Colors.white),),
          ElevatedButton(
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/todo_list');
            },
            child: Text('ToDo list'),)
        ],
      ),
    );
  }
}