part of 'expense_bloc.dart';

///
sealed class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object> get props => [];
}

///
final class ExpenseInitial extends ExpenseState {
  @override
  List<Object> get props => [];
}

///
class ExpenseLoadedState extends ExpenseState {
  ///
  final List<ExpenseModel> expenses;

  @override
  List<Object> get props => [expenses];

  ///
  const ExpenseLoadedState(this.expenses);
}

///
class ExpenseErrorMessageState extends ExpenseState {
  ///
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  ///
  const ExpenseErrorMessageState(this.errorMessage);
}
