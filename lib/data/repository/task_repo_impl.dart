import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_master/data/models/task/task_model.dart';
import 'package:task_master/domain/entity/task/task_entity.dart';
import 'package:task_master/domain/repository/task_repo.dart';

///
class TaskRepoImpl implements TaskRepository {
  ///
  final SupabaseClient client;

  ///
  TaskRepoImpl(this.client);

  @override
  Future<void> addTask(TaskEntity task) async {
    final model = TaskModel(
      id: task.id,
      userId: FirebaseAuth.instance.currentUser?.uid ?? '',
      title: task.title,
      description: task.description,
      assignedTo: task.assignedTo,
      priority: task.priority,
      difficulty: task.difficulty,
      attachmentPath: task.attachmentPath,
    );

    final response = await client.from('tasks').insert(model.toJson());

    log(response.toString());
  }
}
