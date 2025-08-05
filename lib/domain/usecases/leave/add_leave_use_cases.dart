import 'package:task_master/data/models/leave/leave_model.dart';
import 'package:task_master/domain/repository/leave_repository.dart';

///
class AddLeaveUseCases {
  final LeaveRepository _leaveRepository;

  ///
  AddLeaveUseCases(this._leaveRepository);

  ///
  Future<void> call(LeaveModel leave) => _leaveRepository.addLeave(leave);
}
