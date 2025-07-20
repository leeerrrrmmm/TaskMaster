import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/features/expense/widgets/expense_info_widget.dart';
import 'package:task_master/features/expense/widgets/header_widget.dart';
import 'package:task_master/features/expense/widgets/summary_expense_widget.dart';
import 'package:task_master/features/expense/widgets/task_category_widget.dart';
import 'package:task_master/features/widget/gradient_button_widget.dart';

/// [ExpenseReviewScreen]
class ExpenseReviewScreen extends StatefulWidget {
  /// [ExpenseReviewScreen] constructor
  const ExpenseReviewScreen({super.key});

  @override
  State<ExpenseReviewScreen> createState() => _ExpenseReviewScreenState();
}

class _ExpenseReviewScreenState extends State<ExpenseReviewScreen> {
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
                  const SummaryExpenseWidget(),
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
                    btnText: 'Submit Expense',
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
