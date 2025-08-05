import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_master/data/models/task/task_model.dart';
import 'package:task_master/features/task/widgets/task_card_widget.dart';
import 'package:task_master/features/task/widgets/task_info_widget.dart';

///
class TaskListWidget extends StatelessWidget {
  ///
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Center(child: Text('Пользователь не авторизован'));
    }

    final currentUid = currentUser.uid;
    final currentEmail = currentUser.email;

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: supabase.from('tasks').stream(primaryKey: ['id']),
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final allTasks = snapshot.data ?? [];

        final filteredTasks = allTasks.where((taskJson) {
          final task = TaskModel.fromJson(taskJson);

          return task.userId == currentUid || task.assignedTo == currentEmail;
        }).toList();

        if (filteredTasks.isEmpty) {
          return const TaskInfoWidget(); // Нет задач
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredTasks.length,
          itemBuilder: (_, index) {
            final task = TaskModel.fromJson(filteredTasks[index]);

            return TaskCardWidget(task: task);
          },
        );
      },
    );
  }
}
