import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_master/data/models/task/task_model.dart';
import 'package:task_master/features/task/extensions/difficulty_level_extension.dart';
import 'package:task_master/features/task/extensions/priority_level_extension.dart';
import 'package:uuid/uuid.dart';

class ChecksssScreen extends StatefulWidget {
  const ChecksssScreen({super.key});

  @override
  State<ChecksssScreen> createState() => _ChecksssScreenState();
}

class _ChecksssScreenState extends State<ChecksssScreen> {
  Future<void> createTask(TaskModel task) async {
    final supabase = Supabase.instance.client;

    final response = await supabase.from('tasks').insert(task.toJson());

    log(response.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            final firebaseUser = FirebaseAuth.instance.currentUser;

            if (firebaseUser == null) {
              log('Пользователь не авторизован в Firebase');

              return;
            }

            final task = TaskModel(
              id: const Uuid().v4(), // не забудь добавить пакет `uuid`
              userId: firebaseUser.uid,
              title: 'Test Task',
              description: 'Описание задачи',
              difficulty: DifficultyLevel.hard,
              priority: PriorityLevel.medium,
              // createdAt: DateTime.now(),
              assignedTo: 'mychko.mychko@gmail.com',
            );

            try {
              await createTask(task);
              print('Задача успешно отправлена в Supabase');
            } catch (e) {
              print('Ошибка: $e');
            }
          },
          child: const Text('Send supabase request'),
        ),
      ),
    );
  }
}
