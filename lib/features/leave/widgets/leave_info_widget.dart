import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';

/// [ExpenseInfoWidget]
class ExpenseInfoWidget extends StatelessWidget {
  /// [ExpenseInfoWidget] constructor
  const ExpenseInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      width: double.infinity,
      height: 360,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ExpenseInfoWidget Container
          const Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expense',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Expense submited',
                    style: TextStyle(color: AppColors.grey500, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          Image.asset('assets/images/expence.png'),
          const Column(
            children: [
              Text(
                'No Expense Submitted',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                textAlign: TextAlign.center,
                '''It looks like you don’t have any expense submitted. Don’t worry, this space will be updated as new expense submitted.''',
                style: TextStyle(fontSize: 11, color: AppColors.grey500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
