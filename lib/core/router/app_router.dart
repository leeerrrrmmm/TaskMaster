import 'package:go_router/go_router.dart';
import 'package:task_master/features/forgot/forgot_screen.dart';
import 'package:task_master/features/leave/presentation/submit/submit_leave.dart';
import 'package:task_master/features/login/login_screen.dart';
import 'package:task_master/features/main/screens/bottom/bottom_nav_bar.dart';
import 'package:task_master/features/main/screens/main_screen.dart/main_screen.dart';
import 'package:task_master/features/onboarding/onboarding_screen.dart';
import 'package:task_master/features/profile/screens/profile.dart';
import 'package:task_master/features/profile/screens/set_up_profile.dart';
import 'package:task_master/features/profile/screens/work_profile.dart';
import 'package:task_master/features/register/register_screen.dart';
import 'package:task_master/features/task/presentation/create/create_task_screen.dart';
import 'package:task_master/features/task/presentation/task_screen.dart';

/// App Router
final GoRouter appRouter = GoRouter(
  initialLocation: '/submitLeave',
  routes: [
    GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (_, __) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (_, __) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/bottom',
      name: 'bottom',
      builder: (_, __) => const BottomNavBar(),
    ),
    GoRoute(
      path: '/main',
      name: 'main',
      builder: (_, __) => const MainScreen(),
    ),
    GoRoute(
      path: '/setUpProfile',
      name: 'setUpProfile',
      builder: (_, __) => const SetUpProfile(),
    ),
    GoRoute(
      path: '/workProfile',
      name: 'workProfile',
      builder: (_, __) => const WorkProfile(),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (_, __) => const Profile(),
    ),
    GoRoute(
      path: '/forgot',
      name: 'forgot',
      builder: (_, __) => const ForgotScreen(),
    ),
    GoRoute(
      path: '/createTask',
      name: 'createTask',
      builder: (_, __) => const CreateTaskScreen(),
    ),
    GoRoute(
      path: '/task',
      name: 'task',
      builder: (_, __) => const TaskScreen(),
    ),
    GoRoute(
      path: '/submitLeave',
      name: 'submitLeave',
      builder: (_, __) => const SubmitLeave(),
    ),
  ],
);
