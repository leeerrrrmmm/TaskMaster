import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_theme.dart';
import 'package:task_master/router/app_router.dart';

/// App was started from [App]
class App extends StatelessWidget {
  /// Counstructor [App]
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,
    );
  }
}
