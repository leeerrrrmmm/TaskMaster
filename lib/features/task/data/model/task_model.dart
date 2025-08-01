import 'package:task_master/features/task/extensions/diff_level_extension.dart';
import 'package:task_master/features/task/extensions/prior_level_extension.dart';

///
class TaskModel {
  ///
  final String id;

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
  final DateTime createdAt;

  ///
  final String? attachmentPath; // optional: for image/file paths
  ///
  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.assignedTo,
    required this.priority,
    required this.difficulty,
    required this.createdAt,
    this.attachmentPath,
  });

  /// Create TaskModel from JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json['id'].toString(),
    title: json['title'].toString(),
    description: json['description'].toString(),
    assignedTo: json['assignedTo'].toString(),
    priority: PriorityLevel.values.byName(json['priority'].toString()),
    difficulty: DifficultyLevel.values.byName(json['difficulty'].toString()),
    createdAt: DateTime.parse(json['createdAt'].toString()),
    attachmentPath: json['attachmentPath'] != null
        ? json['attachmentPath'].toString()
        : null,
  );

  /// Convert to JSON (e.g., for REST API or local storage)
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'assignedTo': assignedTo,
    'priority': priority?.name,
    'difficulty': difficulty?.name,
    'createdAt': createdAt.toIso8601String(),
    'attachmentPath': attachmentPath,
  };
}
