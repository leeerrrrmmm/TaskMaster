import 'dart:developer';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_master/data/models/expense/expense_model.dart';
import 'package:task_master/domain/entity/expense/expense_entity.dart';
import 'package:task_master/domain/repository/expense_repo.dart';

///
class ExpenseRepoImpl implements ExpenseRepo {
  ///
  final SupabaseClient client;

  ///
  ExpenseRepoImpl(this.client);

  @override
  Future<void> addExpense(ExpenseEntity expense) async {
    final newExpense = ExpenseModel(
      id: expense.id,
      userId: expense.userId,
      expenseCategory: expense.expenseCategory,
      amount: expense.amount,
      description: expense.description,
      tranDate: expense.tranDate,
    );

    final response = await client.from('expenses').insert(newExpense.toJson());

    log(response.toString());
  }
}
