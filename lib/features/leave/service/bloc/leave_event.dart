part of 'leave_bloc.dart';

///
sealed class LeaveEvent extends Equatable {
  const LeaveEvent();

  @override
  List<Object> get props => [];
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
