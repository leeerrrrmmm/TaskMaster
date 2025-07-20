import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';

/// [TaskInfoWidget]
class TaskInfoWidget extends StatelessWidget {
  /// [TaskInfoWidget] constructor
  const TaskInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // TaskInfoWidget Container
          const Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today Task',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'The tasks assigned to you for today',
                    style: TextStyle(color: AppColors.grey500, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          Image.asset('assets/images/noTask.png'),
          const Column(
            children: [
              Text(
                'No Tasks Assigned',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                textAlign: TextAlign.center,
                '''It looks like you don’t have any tasks assigned to you right now. Don’t worry, this space will be updated as new tasks become available.''',
                style: TextStyle(fontSize: 11, color: AppColors.grey500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
