import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_master/features/expense/data/model/expense_model.dart';

part 'expense_event.dart';
part 'expense_state.dart';

///
class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final List<ExpenseModel> _expenses = [];

  /// LOAD EXPENSES
  ExpenseBloc() : super(ExpenseInitial()) {
    on<LoadExpeseEvent>((event, emit) {
      emit(ExpenseLoadedState(_expenses));
    });

    ///ADD EXPENSES
    on<AddExpenseEvent>((event, emit) {
      _expenses.add(event.expense);
      emit(ExpenseLoadedState(_expenses));
    });

    /// REMOVE EXPENSES
    on<RemoveExpenseEvent>((event, emit) {
      _expenses.removeWhere((el) => el.id == event.expense.id);
      emit(ExpenseLoadedState(_expenses));
    });
  }
}
