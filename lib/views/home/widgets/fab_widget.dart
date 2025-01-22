import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/utils/app_colors.dart';
import 'package:to_do/views/home/bloc/home_bloc.dart';
import 'package:to_do/views/tasks/task_view.dart';

class Fab extends StatelessWidget {
  final String id;
  const Fab({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (_) => TaskView(
                          id: id,
                          titleTaskController: null,
                          descriptionTaskController: null,
                          task: null,
                        )))
            .then((value) => context.read<HomeBloc>().add(LoadTasksFetch()));
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(15)),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
