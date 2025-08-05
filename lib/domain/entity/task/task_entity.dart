import 'package:task_master/features/task/extensions/difficulty_level_extension.dart';
import 'package:task_master/features/task/extensions/priority_level_extension.dart';

///
abstract class TaskEntity {
  ///
  final String id;

  ///
  final String userId;

  ///
  final String title;

  ///
  final String description;

  ///
  final String assignedTo;

  ///
  final PriorityLevel? priority;

  ///
  final DifficultyLevel? difficulty;

  ///
  // final DateTime createdAt;

  ///
  final String? attachmentPath; // optional: for image/file paths
  ///
  TaskEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.assignedTo,
    required this.priority,
    required this.difficulty,
    // required this.createdAt,
    this.attachmentPath,
  });
}
