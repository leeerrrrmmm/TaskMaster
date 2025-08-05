import 'package:task_master/domain/entity/task/task_entity.dart';
import 'package:task_master/features/task/extensions/difficulty_level_extension.dart';
import 'package:task_master/features/task/extensions/priority_level_extension.dart';

///
class TaskModel extends TaskEntity {
  ///
  TaskModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.description,
    required super.assignedTo,
    required super.priority,
    required super.difficulty,
    // required this.createdAt,
    super.attachmentPath,
  });

  /// Create TaskModel from JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json['id'].toString(),
    userId: json['user_id'].toString(),
    title: json['title'].toString(),
    description: json['description'].toString(),
    assignedTo: json['assigned_to'].toString(),
    priority: PriorityLevel.values.byName(json['priority_level'].toString()),
    difficulty: DifficultyLevel.values.byName(
      json['difficult_level'].toString(),
    ),
    // createdAt: DateTime.parse(json['createdAt'].toString()),
    attachmentPath: json['imgPath'] is String
        ? json['imgPath'].toString()
        : null,
  );

  /// Convert to JSON (e.g., for REST API or local storage)
  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'title': title,
    'description': description,
    'assigned_to': assignedTo,
    'priority_level': priority?.name,
    'difficult_level': difficulty?.name,
    // 'createdAt': createdAt.toIso8601String(),
    'imgPath': attachmentPath,
  };
}
