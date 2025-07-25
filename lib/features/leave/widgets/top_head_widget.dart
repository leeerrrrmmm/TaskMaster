import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';

///
class TopHeadWidget extends StatelessWidget {
  ///
  const TopHeadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fill Leave Information',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(
          'Information about leave details',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.grey400,
          ),
        ),
      ],
    );
  }
}
