// lib/features/task/widgets/task_card_widget.dart
import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/features/task/data/model/task_model.dart';
import 'package:task_master/features/task/extensions/priority_level_extension.dart';
import 'package:task_master/features/task/widgets/task_tags_widget.dart';

///
class TaskCardWidget extends StatelessWidget {
  ///
  final TaskModel task;

  ///
  const TaskCardWidget({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(8),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TaskTagsWidget(priority: task.priority ?? PriorityLevel.low),
          const Spacer(),
          Container(
            width: double.infinity,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xffE7E7E7),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/profile/authUser.png', scale: 2),
              const Row(
                children: [
                  _TagInfo(icon: Icons.calendar_month, label: '27 Sep'),
                  SizedBox(width: 8),
                  _TagInfo(icon: Icons.message, label: '2'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TagInfo extends StatelessWidget {
  final IconData icon;
  final String label;

  const _TagInfo({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.grey300, size: 16),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
