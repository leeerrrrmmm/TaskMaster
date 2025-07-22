import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_master/core/router/app_router.dart';
import 'package:task_master/core/theme/app_theme.dart';
import 'package:task_master/features/task/service/bloc/task_bloc.dart';

/// App was started from [App]
class App extends StatelessWidget {
  /// Counstructor [App]
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskBloc(),
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,

        theme: AppTheme.lightTheme,
      ),
    );
  }
}
