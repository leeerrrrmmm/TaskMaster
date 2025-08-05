import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_master/data/models/leave/leave_model.dart';
import 'package:task_master/domain/repository/leave_repository.dart';

///
class LeaveRepositoryImpl extends LeaveRepository {
  ///
  final SupabaseClient client;

  ///
  LeaveRepositoryImpl({required this.client});
  @override
  Future<void> addLeave(LeaveModel leave) async {
    final newModel = LeaveModel(
      id: leave.id,
      userId: leave.userId,
      leaveCategory: leave.leaveCategory,
      number: leave.number,
      description: leave.description,
      startLeave: leave.startLeave,
      endLeave: leave.endLeave,
      taskDelegationCategory: leave.taskDelegationCategory,
    );

    log('Creating leave with user_id: ${leave.userId}');

    final response = await client.from('leaves').insert(newModel.toJson());

    log(response.toString());
  }
}
