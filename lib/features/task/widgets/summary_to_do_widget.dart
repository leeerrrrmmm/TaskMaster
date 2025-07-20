import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/features/task/widgets/%20task_progress_card.dart';

/// [SummaryToDoWidget]
class SummaryToDoWidget extends StatelessWidget {
  /// [SummaryToDoWidget] constructor
  const SummaryToDoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        color: const Color(0xfffefefe),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Summary of Your Work',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Your current task progress',
                    style: TextStyle(
                      color: AppColors.grey500,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 8,
            children: [
              TaskProgressCard(
                text: 'To Do',
                imgPath: 'assets/images/todo.png',
              ),
              TaskProgressCard(
                text: 'In Progress',
                imgPath: 'assets/images/progress.png',
              ),
              TaskProgressCard(
                text: 'Done',
                imgPath: 'assets/images/doneTask.png',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
