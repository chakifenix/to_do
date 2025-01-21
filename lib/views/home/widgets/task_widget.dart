import 'package:flutter/material.dart';
import 'package:to_do/utils/app_colors.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// Navigate to Task View to see Task Details
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
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
            onTap: () {
              /// Check or uncheck the task
            },
            child: AnimatedContainer(
              duration: const Duration(microseconds: 600),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: .8)),
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),

          /// Task title
          title: const Padding(
            padding: EdgeInsets.only(bottom: 5, top: 3),
            child: Text(
              'Done',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),

          /// Task Description
          subtitle: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Descriptions',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
              ),

              /// Date of task
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        'SubDate',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
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