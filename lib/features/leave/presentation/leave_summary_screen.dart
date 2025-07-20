import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/features/leave/widgets/header_widget.dart';
import 'package:task_master/features/leave/widgets/leave_category.dart';
import 'package:task_master/features/leave/widgets/leave_info_widget.dart';
import 'package:task_master/features/leave/widgets/total_leave_widget.dart';
import 'package:task_master/features/widget/gradient_button_widget.dart';

/// [LeaveSummaryScreen]
class LeaveSummaryScreen extends StatefulWidget {
  /// [LeaveSummaryScreen] constructor
  const LeaveSummaryScreen({super.key});

  @override
  State<LeaveSummaryScreen> createState() => _LeaveSummaryScreenState();
}

class _LeaveSummaryScreenState extends State<LeaveSummaryScreen> {
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
                  const TotalLeaveWidget(),
                  const SizedBox(height: 16),
                  ExpenseCategoryWidget(
                    curPage: curPage,
                    onTap: (val) {
                      setState(() {
                        curPage = val;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  const ExpenseInfoWidget(),
                  const SizedBox(height: 20),
                  GradientButtonWidget(
                    btnText: 'Submit Leave',
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
