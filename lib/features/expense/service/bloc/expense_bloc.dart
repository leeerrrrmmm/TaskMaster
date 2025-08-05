import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_master/data/models/expense/expense_model.dart';
import 'package:task_master/domain/usecases/expense/add_expense_use_case.dart';

part 'expense_event.dart';
part 'expense_state.dart';

///
class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ///
  AddExpenseUseCase addExpenseUseCase;

  /// LOAD EXPENSES
  ExpenseBloc({required this.addExpenseUseCase}) : super(ExpenseInitial()) {
    on<LoadExpeseEvent>((_, emit) {
      emit(ExpenseInitial());
    });

    ///ADD EXPENSES
    on<AddExpenseEvent>((event, emit) async {
      try {
        await addExpenseUseCase(event.expense); // Use repository → Supabase
        emit(ExpenseLoadedState([event.expense]));
      } catch (e, stackTrace) {
        log('Error adding task: $e', stackTrace: stackTrace);
        emit(const ExpenseErrorMessageState('Failed to create task'));
      }
    });

    /// REMOVE EXPENSES
    on<RemoveExpenseEvent>((_, emit) {
      emit(ExpenseInitial());
    });
  }
}
