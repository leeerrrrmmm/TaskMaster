part of 'leave_bloc.dart';

///
sealed class LeaveEvent extends Equatable {
  @override
  List<Object> get props => [];
  const LeaveEvent();
}

///
class LeaveLoad extends LeaveEvent {
  @override
  List<Object> get props => [];
}

///
class AddLeave extends LeaveEvent {
  ///
  final LeaveModel leave;

  @override
  List<Object> get props => [leave];

  ///
  const AddLeave(this.leave);
}

///
class RemoveLeave extends LeaveEvent {
  ///
  final LeaveModel leave;

  @override
  List<Object> get props => [leave];

  ///
  const RemoveLeave(this.leave);
}
