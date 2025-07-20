import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/features/task/widgets/burnout_stats_widget.dart';
import 'package:task_master/features/task/widgets/header_widget.dart';
import 'package:task_master/features/task/widgets/summary_to_do_widget.dart';
import 'package:task_master/features/task/widgets/task_category_widget.dart';
import 'package:task_master/features/task/widgets/task_info_widget.dart';
import 'package:task_master/features/widget/gradient_button_widget.dart';

/// [TaskScreen]
class TaskScreen extends StatefulWidget {
  /// [TaskScreen] constructor
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  int curPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      body: Stack(
        children: [
          const HeaderWidget(),

          Positioned.fill(
            top: 180,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 12.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SummaryToDoWidget(),
                  const SizedBox(height: 16),
                  const BurnoutStatsWidget(),
                  const SizedBox(height: 16),
                  TaskCategoryWidget(
                    curPage: curPage,
                    onTap: (val) {
                      setState(() {
                        curPage = val;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  const TaskInfoWidget(),
                  const SizedBox(height: 20),
                  GradientButtonWidget(
                    btnText: 'Create Task',
                    onTap: () => context.pushNamed('createTask'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
