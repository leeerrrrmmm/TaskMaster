import 'package:task_master/features/leave/extension/leave_category_extension.dart';
import 'package:task_master/features/leave/extension/task_delegation_cat_extension.dart';

///
class LeaveModel {
  ///
  final String id;

  ///
  final String number;

  ///
  final LeaveCategory leaveCategory;

  ///
  final TaskDelegationCat taskDelegationCategory;

  ///
  final DateTime startLeave;

  ///
  final DateTime endLeave;

  ///
  final String description;

  ///
  final DateTime createdAt;

  ///
  const LeaveModel({
    required this.id,
    required this.number,
    required this.leaveCategory,
    required this.taskDelegationCategory,
    required this.startLeave,
    required this.endLeave,
    required this.description,
    required this.createdAt,
  });

  ///
  factory LeaveModel.fromJson(Map<String, dynamic> json) => LeaveModel(
    id: DateTime.now().toIso8601String(),
    number: json['number'].toString(),
    leaveCategory: LeaveCategory.values.byName(
      json['leaveCategory'].toString(),
    ),
    taskDelegationCategory: TaskDelegationCat.values.byName(
      json['taskDelegationCategory'].toString(),
    ),
    startLeave: DateTime.parse(json['startLeave'].toString()),
    endLeave: DateTime.parse(json['endLeave'].toString()),
    description: json['description'].toString(),
    createdAt: DateTime.parse(json['createdAt'].toString()),
  );
}
