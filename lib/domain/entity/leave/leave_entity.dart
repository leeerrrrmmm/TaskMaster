import 'package:task_master/features/leave/extension/leave_category_extension.dart';
import 'package:task_master/features/leave/extension/task_delegation_cat_extension.dart';

///
class LeaveEntity {
  ///
  final String id;

  ///
  final String userId;

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
  const LeaveEntity({
    required this.id,
    required this.userId,
    required this.number,
    required this.leaveCategory,
    required this.taskDelegationCategory,
    required this.startLeave,
    required this.endLeave,
    required this.description,
  });
}
