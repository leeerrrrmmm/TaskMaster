import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/core/widget/gradient_button_widget.dart';

/// [ClockScreen]
class ClockScreen extends StatelessWidget {
  /// [ClockScreen] constructor
  const ClockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                          "Let's Clock-In",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Don't miss your clock in schedule",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset('assets/images/time.png'),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 16,
                children: [
                  TotalTrackWidget(
                    onTap: () {
                      //TODO create startTrackTime logic
                    },
                  ),
                  WorkingPeriodWidget(),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// [TotalTrackWidget]
class TotalTrackWidget extends StatelessWidget {
  /// [TotalTrackWidget] constructor
  const TotalTrackWidget({required this.onTap, super.key});

  ///
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: const Color(0xfffefefe),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Working Hour',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Paid Period 1 Sept 2024 - 30 Setp 2024',
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              Expanded(child: TodayTimeWidget()),
              Expanded(child: ThisPeriodTrackWidget()),
            ],
          ),
          GradientButtonWidget(
            btnText: 'Clock In',
            onTap: () {
              //TODO start Time Logic
            },
          ),
          const SizedBox(height: 2),
        ],
      ),
    );
  }
}

/// [WorkingPeriodWidget]
class WorkingPeriodWidget extends StatelessWidget {
  /// [WorkingPeriodWidget] constructor
  const WorkingPeriodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // WorkingPeriodWidget Container
          const Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Working Period',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Your working time in this paid period',
                    style: TextStyle(color: AppColors.grey500, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          Image.asset('assets/images/noTask.png'),
          const Column(
            children: [
              Text(
                'No Working Time Available',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                textAlign: TextAlign.center,
                '''It looks like you don’t have any working time in this period. Don’t worry, this space will be updated as new working time submitted.''',
                style: TextStyle(fontSize: 11, color: AppColors.grey500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// [TodayTimeWidget]
class TodayTimeWidget extends StatelessWidget {
  /// [TodayTimeWidget] constructor
  const TodayTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
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
                Image.asset('assets/images/clock.png'),
                const Text(
                  'Today',
                  style: TextStyle(color: AppColors.grey500, fontSize: 14),
                ),
              ],
            ),
            const Text(
              '00:00 Hrs',
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

/// [ThisPeriodTrackWidget]
class ThisPeriodTrackWidget extends StatelessWidget {
  /// [ThisPeriodTrackWidget] constructor
  const ThisPeriodTrackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
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
                Image.asset('assets/images/clock.png'),
                const Text(
                  'This Pay Period',
                  style: TextStyle(color: AppColors.grey500, fontSize: 14),
                ),
              ],
            ),
            const Text(
              '00:00 Hrs',
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
