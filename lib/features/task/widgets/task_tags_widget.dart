// lib/features/task/widgets/task_tags_widget.dart
import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/features/task/extensions/priority_level_extension.dart';

///
class TaskTagsWidget extends StatelessWidget {
  ///
  final PriorityLevel priority;

  ///
  const TaskTagsWidget({required this.priority, super.key});

  Color _getPriorityColor() {
    switch (priority) {
      case PriorityLevel.high:
        return AppColors.error500;
      case PriorityLevel.medium:
        return AppColors.warning500;
      case PriorityLevel.low:
        return AppColors.success500;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 90,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.grey300,
          ),
          child: const Center(
            child: Text(
              'In Progress',
              style: TextStyle(
                color: AppColors.grey600,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Container(
          width: 70,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: _getPriorityColor(),
          ),
          child: Center(
            child: Text(
              priority.label,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
