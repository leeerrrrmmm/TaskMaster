import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';

/// [LeaveInfoWidget]
class LeaveInfoWidget extends StatelessWidget {
  /// [LeaveInfoWidget] constructor
  const LeaveInfoWidget({super.key});

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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/lea.png'),
          const Text(
            'No Leave Submitted!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            textAlign: TextAlign.center,
            '''Ready to catch some fresh air? Click “Submit Leave” and\ntake that well-deserved break!''',
            style: TextStyle(fontSize: 11, color: AppColors.grey500),
          ),
        ],
      ),
    );
  }
}
