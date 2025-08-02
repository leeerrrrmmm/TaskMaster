part of 'expense_bloc.dart';

///
sealed class ExpenseEvent extends Equatable {
  @override
  List<Object> get props => [];
  const ExpenseEvent();
}

///
class LoadExpeseEvent extends ExpenseEvent {
  @override
  List<Object> get props => [];
}

///
class AddExpenseEvent extends ExpenseEvent {
  ///
  final ExpenseModel expense;

  @override
  List<Object> get props => [expense];

  ///
  const AddExpenseEvent(this.expense);
}

///
class RemoveExpenseEvent extends ExpenseEvent {
  ///
  final ExpenseModel expense;

  @override
  List<Object> get props => [expense];

  ///
  const RemoveExpenseEvent(this.expense);
}
