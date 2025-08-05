import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/domain/auth/auth_facade.dart';
import 'package:task_master/domain/auth/auth_repository.dart';
import 'package:task_master/domain/auth/google_auth_service.dart';
import 'package:task_master/domain/user/user_repository.dart';
import 'package:task_master/features/task/presentation/create/task_list_widget.dart';

/// [MainScreen]
class MainScreen extends StatefulWidget {
  /// [MainScreen] constructor
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final authFacade = AuthFacade(
    AuthRepository(),
    GoogleAuthService(),
    UserRepository(),
  );

  Map<String, dynamic>? userData;

  Future<void> loadUserData() async {
    final data = await authFacade.getAdditionalUserData();

    setState(() {
      userData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: Text('Пользователь не авторизован')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.grey200,
        title: GestureDetector(
          onTap: () => context.pushNamed('profile'),
          child: Row(
            children: [
              Image.asset('assets/profile/authUser.png'),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData?['displayName'].toString() ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    userData?['position'].toString() ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff6e62ff),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => context.pushNamed('chat'),
            child: CircleAvatar(
              backgroundColor: const Color(0xfff4f5ff),
              child: Image.asset('assets/images/notif.png'),
            ),
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
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: Column(
          children: [
            TopWidget(),
            SizedBox(height: 16),
            MeetingWidget(),
            SizedBox(height: 16),
            TaskListWidget(), // ← Здесь уже фильтруются задачи по UID и email
          ],
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
