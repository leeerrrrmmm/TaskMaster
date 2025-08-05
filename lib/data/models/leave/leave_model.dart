import 'package:task_master/domain/entity/leave/leave_entity.dart';
import 'package:task_master/features/leave/extension/leave_category_extension.dart';
import 'package:task_master/features/leave/extension/task_delegation_cat_extension.dart';

///
class LeaveModel extends LeaveEntity {
  ///
  const LeaveModel({
    required super.id,
    required super.userId,
    required super.number,
    required super.leaveCategory,
    required super.taskDelegationCategory,
    required super.startLeave,
    required super.endLeave,
    required super.description,
  });

  ///
  factory LeaveModel.fromJson(Map<String, dynamic> json) => LeaveModel(
    id: DateTime.now().toIso8601String(),
    userId: json['user_id'].toString(),
    number: json['number'].toString(),
    leaveCategory: LeaveCategory.values.byName(
      json['leave_category'].toString(),
    ),
    taskDelegationCategory: TaskDelegationCat.values.byName(
      json['task_delegation_ategory'].toString(),
    ),
    startLeave: DateTime.parse(json['start_leave'].toString()),
    endLeave: DateTime.parse(json['end_leave'].toString()),
    description: json['description'].toString(),
  );

  ///
  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'number': number,
    'leave_category': leaveCategory.name,
    'task_delegation_ategory': taskDelegationCategory.name,
    'start_leave': startLeave.toIso8601String(),
    'end_leave': endLeave.toIso8601String(),
    'description': description,
  };
}
