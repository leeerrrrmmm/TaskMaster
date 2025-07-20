import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';

/// [HeaderWidget]
class HeaderWidget extends StatelessWidget {
  /// [HeaderWidget] constructor
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.only(left: 16.0),
        width: double.infinity,
        height: 280,
        decoration: const BoxDecoration(
          color: AppColors.purple500,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Expense Summary",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Claim your expenses here',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset('assets/images/card.png'),
          ],
        ),
      ),
    );
  }
}
