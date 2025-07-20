import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/features/expense/widgets/expense_progress_card.dart';

/// [SummaryExpenseWidget]
class SummaryExpenseWidget extends StatelessWidget {
  /// [SummaryExpenseWidget] constructor
  const SummaryExpenseWidget({super.key});

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
                    'Total Expense',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Period 1 Jan 2024 - 30 Dec 2024',
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
              ExpenseProgressCard(
                text: 'Total',
                imgPath: 'assets/images/total.png',
              ),
              ExpenseProgressCard(
                text: 'Rewiew',
                imgPath: 'assets/images/review.png',
              ),
              ExpenseProgressCard(
                text: 'Approved',
                imgPath: 'assets/images/approved.png',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
