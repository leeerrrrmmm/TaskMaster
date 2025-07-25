import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_master/core/router/app_router.dart';
import 'package:task_master/core/theme/app_theme.dart';
import 'package:task_master/features/leave/service/bloc/leave_bloc.dart';
import 'package:task_master/features/task/service/bloc/task_bloc.dart';

/// App was started from [App]
class App extends StatelessWidget {
  /// Counstructor [App]
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TaskBloc()),
        BlocProvider(create: (_) => LeaveBloc()),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,

        theme: AppTheme.lightTheme,
      ),
    );
  }
}
