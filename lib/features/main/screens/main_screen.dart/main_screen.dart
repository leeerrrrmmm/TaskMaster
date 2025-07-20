import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';

/// [MainScreen]
class MainScreen extends StatefulWidget {
  /// [MainScreen] constructor
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.grey200,
        title: Row(
          children: [
            const SizedBox(width: 0),
            Image.asset('assets/profile/authUser.png'),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tonald Drump', style: TextStyle(fontSize: 16)),
                Text(
                  'Flutter Developer',
                  style: TextStyle(fontSize: 12, color: Color(0xff6e62ff)),
                ),
              ],
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundColor: const Color(0xfff4f5ff),
            child: Image.asset('assets/images/notif.png'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0, left: 8.0),
            child: CircleAvatar(
              backgroundColor: const Color(0xfff4f5ff),
              child: Image.asset('assets/images/bell.png'),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xfff1f3f8),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: Column(
            spacing: 16,
            children: [TopWidget(), MeetingWidget(), TaskWidget()],
          ),
        ),
      ),
    );
  }
}

/// [TopWidget]
class TopWidget extends StatelessWidget {
  /// [TopWidget] constructor
  const TopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xff795ffc),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Work Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  'Today task & presence activity',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          Image.asset('assets/images/cam.png'),
        ],
      ),
    );
  }
}

/// [MeetingWidget]
class MeetingWidget extends StatelessWidget {
  /// [MeetingWidget] constructor
  const MeetingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Meeting Container
          const Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today Meeting',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Your schedule for the day',
                    style: TextStyle(color: AppColors.grey500, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          Image.asset('assets/images/noMeet.png'),
          const Text(
            'No Meeting Available',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const Text(
            textAlign: TextAlign.center,
            '''It looks loke you fon't have any meetings scheduled at the moment. This space will be updated as new meetings are added''',
            style: TextStyle(fontSize: 11, color: AppColors.grey500),
          ),
        ],
      ),
    );
  }
}

/// [TaskWidget]
class TaskWidget extends StatelessWidget {
  /// [TaskWidget] constructor
  const TaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // TaskWidget Container
          const Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today Task',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'The tasks assigned to you for today',
                    style: TextStyle(color: AppColors.grey500, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          Image.asset('assets/images/noTask.png'),
          const Text(
            'No Task Assigned',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          const Text(
            textAlign: TextAlign.center,
            '''It looks loke you fon't have any tasks assigned to you right now. Don't worry, this space will be updated as new tasks become available.''',
            style: TextStyle(fontSize: 11, color: AppColors.grey500),
          ),
        ],
      ),
    );
  }
}
