import 'package:flutter/material.dart';
import 'package:to_do/views/tasks/widgets/task_view_appbar.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: TaskViewAppBar());
  }
}
