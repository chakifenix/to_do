import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:to_do/extensions/space_exs.dart';
import 'package:to_do/utils/app_colors.dart';
import 'package:to_do/utils/app_str.dart';
import 'package:to_do/utils/constants.dart';
import 'package:to_do/views/home/widgets/fab_widget.dart';
import 'package:to_do/views/home/widgets/task_widget.dart';

import 'package:animate_do/animate_do.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<int> testing = [234, 23432];
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: const Fab(),
      body: _buildHomeBody(textTheme),
    );
  }

  /// Home Body
  Widget _buildHomeBody(TextTheme textTheme) {
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
                const SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                    value: 0.5,
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
                      '1 of 3 task',
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

          /// Tasks
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: testing.isNotEmpty

                  /// Task list not empty
                  ? ListView.builder(
                      itemCount: testing.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Slidable(
                            startActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (_) {
                                      onDismissed(
                                        index,
                                      );
                                    },
                                    backgroundColor: const Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ]),
                            child: const TaskWidget());
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
                                animate: testing.isNotEmpty ? false : true),
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

  void onDismissed(int index) {
    setState(() {
      testing.removeAt(index);
    });
  }
}
