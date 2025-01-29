import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do/extensions/space_exs.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/utils/app_colors.dart';
import 'package:to_do/utils/app_str.dart';
import 'package:to_do/utils/constants.dart';
import 'package:to_do/views/home/bloc/home_bloc.dart';
import 'package:to_do/views/home/widgets/fab_widget.dart';
import 'package:to_do/views/home/widgets/task_widget.dart';

import 'package:animate_do/animate_do.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Check value of circle indicator
  dynamic valueOfIndicator(List<Task> task) {
    if (task.isNotEmpty) {
      return task.length;
    } else {
      return 3;
    }
  }

  // Check Done Tasks
  int checkDoneTask(List<Task> tasks) {
    int i = 0;
    for (Task doneTask in tasks) {
      if (doneTask.isCompleted) {
        i++;
      }
    }
    return i;
  }

  void updateParentState(String newText) {
    setState(() {});
  }

  final List<String> items = ['All Tasks', 'Done', 'Not Done'];
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const LoadTasksFetch(filter: null));
  }

  // List<Task> currentTasks = [];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.taskDeleted) {
          // context.read<HomeBloc>().add(LoadTasksFetch());
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: Fab(
            id: state.tasksList.length.toString(),
          ),
          body: _buildHomeBody(textTheme, state),
        );
      },
    );
  }

  /// Home Body
  Widget _buildHomeBody(TextTheme textTheme, HomeState state) {
    // final inCompleteTasks =
    //     state.tasksList.where((task) => !task.isCompleted).toList();
    // final completeTasks =
    //     state.tasksList.where((task) => task.isCompleted).toList();
    // print(state.tasksList);

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          /// Custom AppBar
          Container(
            margin: const EdgeInsets.only(top: 60),
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Progress Indicator
                SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor:
                        const AlwaysStoppedAnimation(AppColors.primaryColor),
                    value: checkDoneTask(state.tasksList) /
                        valueOfIndicator(state.tasksList),
                  ),
                ),

                /// Space
                25.w,

                ///Top Level task info
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStr.mainTitle,
                      style: textTheme.displayLarge,
                    ),
                    3.h,
                    Text(
                      '${checkDoneTask(state.tasksList)} of ${state.tasksList.length} task',
                      style: textTheme.titleMedium,
                    )
                  ],
                )
              ],
            ),
          ),

          ///Divider
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(
              thickness: 2,
              indent: 100,
            ),
          ),

          ///Filter
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: const Text(
                'Filter',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              items: items
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                      ))
                  .toList(),
              value: selectedValue,
              onChanged: (String? value) {
                setState(() {
                  selectedValue = value;
                  context
                      .read<HomeBloc>()
                      .add(LoadTasksFetch(filter: selectedValue));
                });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),

          /// Tasks
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: state.tasksList.isNotEmpty

                  /// Task list not empty
                  ? ListView.builder(
                      itemCount: state.tasksList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Slidable(
                            startActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (_) {
                                      // onDismissed(
                                      //   index,
                                      // );
                                      context.read<HomeBloc>().add(
                                          DeleteTaskFetch(
                                              id: state.tasksList[index].id));
                                    },
                                    backgroundColor: const Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ]),
                            child: TaskWidget(
                                task: state.tasksList[index],
                                stateChanged: updateParentState));
                      })

                  ///Task list is empty
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ///Lottie Anime
                        FadeInUp(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Lottie.asset(lottieURL,
                                animate:
                                    state.tasksList.isNotEmpty ? false : true),
                          ),
                        ),

                        ///sub Text
                        FadeInUp(
                            from: 30, child: const Text(AppStr.doneAllTask))
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }
}
