part of 'leave_bloc.dart';

///
sealed class LeaveState extends Equatable {
  @override
  List<Object> get props => [];

  const LeaveState();
}

///
final class LeaveInitial extends LeaveState {
  @override
  List<Object> get props => [];
}

///
class LeaveLoaded extends LeaveState {
  ///
  final List<LeaveModel> leaves;

  @override
  List<Object> get props => [leaves];

  ///
  const LeaveLoaded(this.leaves);
}

///
class LeaveBlocError extends LeaveState {
  ///
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  ///
  const LeaveBlocError(this.errorMessage);
}
