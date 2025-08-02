import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';

/// [LeaveCategoryWidget]
class LeaveCategoryWidget extends StatelessWidget {
  /// [LeaveCategoryWidget] constructor
  const LeaveCategoryWidget({
    required this.curPage,
    required this.onTap,
    super.key,
  });

  ///
  final void Function(int index) onTap;

  ///
  final int curPage;

  @override
  Widget build(BuildContext context) {
    final data = ['Review', 'Approved', 'Rejected'];

    return Container(
      padding: const EdgeInsets.all(2),
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 4,
        children: [
          ...List.generate(
            3,
            (i) => GestureDetector(
              onTap: () => onTap(i),
              child: AnimatedContainer(
                curve: Curves.linearToEaseOut,
                decoration: BoxDecoration(
                  color: i == curPage ? AppColors.purple500 : AppColors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                width: 118,
                height: 34,
                duration: const Duration(milliseconds: 400),
                child: Center(
                  child: Text(
                    data[i],
                    style: TextStyle(
                      color: i == curPage ? AppColors.white : AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
