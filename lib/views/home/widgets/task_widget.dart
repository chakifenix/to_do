import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do/data/task_storage.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/utils/app_colors.dart';
import 'package:to_do/views/tasks/task_view.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({super.key, required this.task, required this.stateChanged});

  final Task task;
  final Function(String) stateChanged;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController textEditingControllerForTitle = TextEditingController();
  TextEditingController textEditingControllerForSubTitle =
      TextEditingController();

  @override
  void initState() {
    textEditingControllerForTitle.text = widget.task.title;
    textEditingControllerForSubTitle.text = widget.task.subtitle;
    super.initState();
  }

  @override
  void dispose() {
    textEditingControllerForTitle.dispose();
    textEditingControllerForSubTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// Navigate to Task View to see Task Details
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (ctx) => TaskView(
                  titleTaskController: textEditingControllerForTitle,
                  descriptionTaskController: textEditingControllerForSubTitle,
                  task: widget.task,
                  id: widget.task.id)),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: widget.task.isCompleted
                ? const Color.fromARGB(154, 119, 144, 229)
                : Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  offset: const Offset(0, 4),
                  blurRadius: 10)
            ]),
        child: ListTile(
          /// Check Icon
          leading: GestureDetector(
            onTap: () async {
              /// Check or uncheck the task
              widget.task.isCompleted = !widget.task.isCompleted;
              await TaskStorage.updateTask(widget.task);
              widget.stateChanged('kjsajdj');
              setState(() {});
            },
            child: AnimatedContainer(
              duration: const Duration(microseconds: 600),
              decoration: BoxDecoration(
                  color: widget.task.isCompleted
                      ? AppColors.primaryColor
                      : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: .8)),
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),

          /// Task title
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 3),
            child: Text(
              textEditingControllerForTitle.text,
              style: TextStyle(
                  color: widget.task.isCompleted
                      ? AppColors.primaryColor
                      : Colors.black,
                  fontWeight: FontWeight.w500,
                  decoration: widget.task.isCompleted
                      ? TextDecoration.lineThrough
                      : null),
            ),
          ),

          ///
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Task Description
              Text(
                textEditingControllerForSubTitle.text,
                style: TextStyle(
                    color: widget.task.isCompleted
                        ? AppColors.primaryColor
                        : Colors.black,
                    fontWeight: FontWeight.w300,
                    decoration: widget.task.isCompleted
                        ? TextDecoration.lineThrough
                        : null),
              ),

              /// Date of task
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('hh.mm').format(widget.task.createdTime),
                        style: TextStyle(
                            fontSize: 14,
                            color: widget.task.isCompleted
                                ? Colors.white
                                : Colors.grey),
                      ),
                      Text(
                        DateFormat.yMMMEd().format(widget.task.createdDate),
                        style: TextStyle(
                            fontSize: 12,
                            color: widget.task.isCompleted
                                ? Colors.white
                                : Colors.grey),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
