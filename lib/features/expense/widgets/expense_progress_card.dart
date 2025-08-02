import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';

/// [ ExpenseProgressCard]
class ExpenseProgressCard extends StatelessWidget {
  /// [ ExpenseProgressCard] constructor
  const ExpenseProgressCard({
    required this.text,
    required this.imgPath,
    super.key,
  });

  ///
  final String imgPath;

  ///
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112,
      height: 72,
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 4,
              children: [
                Image.asset(imgPath),
                Text(
                  text,
                  style: const TextStyle(
                    color: AppColors.grey500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const Text(
              r'$0',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
