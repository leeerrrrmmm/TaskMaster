// lib/features/task/widgets/task_list_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_master/features/task/service/bloc/task_bloc.dart';
import 'package:task_master/features/task/service/bloc/task_state.dart';
import 'package:task_master/features/task/widgets/task_card_widget.dart';
import 'package:task_master/features/task/widgets/task_info_widget.dart';

///
class TaskListWidget extends StatelessWidget {
  ///
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (_, state) {
        return state is TaskBlocLoaded && state.tasks.isNotEmpty
            ? Column(
                children: state.tasks
                    .map((task) => TaskCardWidget(task: task))
                    .toList(),
              )
            : const TaskInfoWidget();
      },
    );
  }
}
