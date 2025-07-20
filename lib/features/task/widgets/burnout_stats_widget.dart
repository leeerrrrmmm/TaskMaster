import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';

/// [BurnoutStatsWidget]
class BurnoutStatsWidget extends StatelessWidget {
  /// [BurnoutStatsWidget] constructor
  const BurnoutStatsWidget({super.key});

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      const Text(
                        'Burnout Stats',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 25,
                        decoration: BoxDecoration(
                          color: const Color(0xff47c28b),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Center(
                          child: Text(
                            'Good',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "You'v maintain your task at the right pace! keep it up!",
                    style: TextStyle(
                      color: AppColors.grey500,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.grey200,
              border: Border.all(color: AppColors.grey100),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/images/gSmile.png'),
                Container(
                  width: 280,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xff47c28b),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
