import 'package:flutter/material.dart';

class CreateANewTask extends StatefulWidget {
  const CreateANewTask({super.key});

  @override
  State<CreateANewTask> createState() => _CreateANewTaskState();
}

class _CreateANewTaskState extends State<CreateANewTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Text('Create a new Task')),
    );
  }
}
