import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/features/leave/widgets/leave_progress__card.dart';

/// [TotalLeaveWidget]
class TotalLeaveWidget extends StatelessWidget {
  /// [TotalLeaveWidget] constructor
  const TotalLeaveWidget({super.key});

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
                    'Total Leave',
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
              LeaveProgressCard(
                text: 'Available',
                imgPath: 'assets/images/approved.png',
              ),
              LeaveProgressCard(
                text: 'Leave Use',
                imgPath: 'assets/images/purple.png',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
