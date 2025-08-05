import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_master/core/db/supabase/supabase_client.dart';
import 'package:task_master/core/router/app_router.dart';
import 'package:task_master/core/theme/app_theme.dart';
import 'package:task_master/data/repository/expense_repo.dart';
import 'package:task_master/data/repository/leave_repository_impl.dart';
import 'package:task_master/data/repository/task_repo_impl.dart';
import 'package:task_master/domain/repository/expense_repo.dart';
import 'package:task_master/domain/repository/leave_repository.dart';
import 'package:task_master/domain/repository/task_repo.dart';
import 'package:task_master/domain/usecases/expense/add_expense_use_case.dart';
import 'package:task_master/domain/usecases/leave/add_leave_use_cases.dart';
import 'package:task_master/domain/usecases/task/add_task_use_case.dart';
import 'package:task_master/features/expense/service/bloc/expense_bloc.dart';
import 'package:task_master/features/leave/service/bloc/leave_bloc.dart';
import 'package:task_master/features/task/service/bloc/task_bloc.dart';

/// App was started from [App]
class App extends StatelessWidget {
  /// Counstructor [App]
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskRepository taskRepository = TaskRepoImpl(
      SupabaseClientInstance.client,
    );
    final AddTaskUseCase addTaskUseCase = AddTaskUseCase(taskRepository);

    final ExpenseRepo expenseTaskRepoImpl = ExpenseRepoImpl(
      SupabaseClientInstance.client,
    );

    final AddExpenseUseCase expenseTaskRepo = AddExpenseUseCase(
      expenseRepo: expenseTaskRepoImpl,
    );

    final LeaveRepository leaveRepository = LeaveRepositoryImpl(
      client: SupabaseClientInstance.client,
    );

    final AddLeaveUseCases addLeaveUseCases = AddLeaveUseCases(leaveRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TaskBloc(addTaskUseCase: addTaskUseCase)),
        BlocProvider(
          create: (_) => ExpenseBloc(addExpenseUseCase: expenseTaskRepo),
        ),
        BlocProvider(create: (_) => LeaveBloc(addLeaveUseCases)),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,

        theme: AppTheme.lightTheme,
      ),
    );
  }
}
