import 'package:task_master/data/models/leave/leave_model.dart';

///
abstract class LeaveRepository {
  ///
  Future<void> addLeave(LeaveModel leave);
}
