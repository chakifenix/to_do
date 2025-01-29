import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:to_do/extensions/space_exs.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/utils/app_colors.dart';
import 'package:to_do/utils/app_str.dart';
import 'package:to_do/utils/constants.dart';
import 'package:to_do/views/home/bloc/home_bloc.dart';
import 'package:to_do/views/tasks/components/date_time_selection.dart';
import 'package:to_do/views/tasks/components/rep_textfield.dart';
import 'package:to_do/views/tasks/widgets/task_view_appbar.dart';

class TaskView extends StatefulWidget {
  const TaskView({
    super.key,
    required this.titleTaskController,
    required this.descriptionTaskController,
    required this.task,
    required this.id,
  });
  final TextEditingController? titleTaskController;
  final TextEditingController? descriptionTaskController;
  final Task? task;
  final String id;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  String? title;
  String? subTitle;
  DateTime? time;
  DateTime? date;

  String showTime(DateTime? time) {
    if (widget.task?.createdTime == null) {
      if (time == null) {
        return DateFormat('HH:mm').format(DateTime.now()).toString();
      } else {
        return DateFormat('HH:mm').format(time).toString();
      }
    } else {
      return DateFormat('HH:mm').format(widget.task!.createdTime).toString();
    }
  }

  String showDate(DateTime? date) {
    if (widget.task?.createdDate == null) {
      if (date == null) {
        return DateFormat.yMMMEd().format(DateTime.now()).toString();
      } else {
        return DateFormat.yMMMEd().format(date).toString();
      }
    } else {
      return DateFormat.yMMMEd().format(widget.task!.createdDate).toString();
    }
  }

  DateTime showDateAsDateTime(DateTime? date) {
    if (widget.task?.createdDate == null) {
      if (date == null) {
        return DateTime.now();
      } else {
        return date;
      }
    } else {
      return widget.task!.createdDate;
    }
  }

// Main Function for creating or updating tasks
  dynamic isTaskAlreadyExistUpdateOtherWiseCreate() {
    if (widget.titleTaskController?.text != null &&
        widget.descriptionTaskController?.text != null) {
      try {
        widget.titleTaskController?.text = title ?? '';
        widget.descriptionTaskController?.text = subTitle ?? '';
        context.read<HomeBloc>().add(UpdateTaskFetch(
            task: Task(
                id: widget.task!.id,
                title: widget.titleTaskController!.text,
                subtitle: widget.descriptionTaskController!.text,
                createdTime: widget.task!.createdTime,
                createdDate: widget.task!.createdTime,
                isCompleted: widget.task!.isCompleted)));
        Navigator.pop(context);
      } catch (e) {
        updateTaskWarning(context);
      }
    } else {
      if (title != null && subTitle != null) {
        var task = Task(
            id: widget.id,
            title: title ?? '',
            subtitle: subTitle ?? '',
            createdTime: time ?? DateTime.now(),
            createdDate: date ?? DateTime.now(),
            isCompleted: false);

        context.read<HomeBloc>().add(AddNewTaskFetch(task: task));
        Navigator.pop(context);
      } else {
        emptyWarning(context);
      }
    }
  }

// if any Task already exist return true otherwise false
  bool isTaskAlreadyExist() {
    if (widget.titleTaskController?.text == null &&
        widget.descriptionTaskController?.text == null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        /// AppBar
        appBar: const TaskViewAppBar(),

        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// Top Side texts
                _buildTopSideTexts(textTheme),

                /// Main Task Activity View
                _buildMainTaskViewActivity(textTheme, context),

                /// Bottom Side Buttons
                _buildBottomSideButtons()
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Bottom Side Buttons
  Widget _buildBottomSideButtons() {
    // final newTask = Task(
    //     id: '1',
    //     title: 'Learn Flutter',
    //     subtitle: 'Work on shared preferences',
    //     createdTime: DateTime.now(),
    //     createdDate: DateTime.now(),
    //     isCompleted: true);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: isTaskAlreadyExist()
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceEvenly,
        children: [
          isTaskAlreadyExist()
              ? Container()
              :

              ///Delete current task button
              MaterialButton(
                  onPressed: () {
                    context
                        .read<HomeBloc>()
                        .add(DeleteTaskFetch(id: widget.task!.id));
                    Navigator.pop(context);
                  },
                  minWidth: 150,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  height: 55,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.close,
                        color: AppColors.primaryColor,
                      ),
                      5.w,
                      const Text(
                        AppStr.deleteTask,
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),

          /// Add or Update Task
          MaterialButton(
            onPressed: () async {
              isTaskAlreadyExistUpdateOtherWiseCreate();
            },
            minWidth: 150,
            color: AppColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            height: 55,
            child: Text(
              isTaskAlreadyExist()
                  ? AppStr.addTaskString
                  : AppStr.updateTaskString,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  /// Main Task View Activity
  Widget _buildMainTaskViewActivity(TextTheme textTheme, BuildContext context) {
    return SizedBox(
      height: 530,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title of textfield
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              AppStr.titleOfTitleTextField,
              style: textTheme.headlineMedium,
            ),
          ),

          /// Task title
          RepTextField(
            controller: widget.titleTaskController,
            onFieldSubmitted: (String inputTitle) {
              title = inputTitle;
            },
            onChanged: (String inputTitle) {
              title = inputTitle;
            },
          ),

          10.h,

          /// Task title
          RepTextField(
            controller: widget.descriptionTaskController,
            isForDescription: true,
            onFieldSubmitted: (String inputSubTitle) {
              subTitle = inputSubTitle;
            },
            onChanged: (String inputSubTitle) {
              subTitle = inputSubTitle;
            },
          ),

          /// Time Selection
          DateTimeSelectionWidget(
            onTap: () {
              DatePicker.showTimePicker(
                context,
                currentTime: showDateAsDateTime(time),
                onChanged: (dateTime) {},
                onConfirm: (dateTime) {
                  setState(() {
                    if (widget.task?.createdTime == null) {
                      time = dateTime;
                    } else {
                      widget.task!.createdTime = dateTime;
                    }
                  });
                },
              );
            },
            title: AppStr.timeString,
            time: showTime(time),
            isTime: true,
          ),

          /// Date Selection
          DateTimeSelectionWidget(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                currentTime: showDateAsDateTime(date),
                maxTime: DateTime(2030, 4, 5),
                minTime: DateTime.now(),
                onConfirm: (dateTime) {
                  setState(() {
                    if (widget.task?.createdDate == null) {
                      date = dateTime;
                    } else {
                      widget.task!.createdTime = dateTime;
                    }
                  });
                },
              );
            },
            title: AppStr.dateString,
            time: showDate(date),
            isTime: false,
          ),
        ],
      ),
    );
  }

  /// Top Side Texts
  Widget _buildTopSideTexts(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Divider - grey
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
          RichText(
            text: TextSpan(
                text: isTaskAlreadyExist()
                    ? AppStr.addNewTask
                    : AppStr.updateCurrentTask,
                style: textTheme.titleLarge,
                children: const [
                  TextSpan(
                      text: AppStr.taskStrnig,
                      style: TextStyle(fontWeight: FontWeight.w400))
                ]),
          ),

          /// Divider - grey
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
