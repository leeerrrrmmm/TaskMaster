import 'package:task_master/domain/entity/expense/expense_entity.dart';

///
abstract class ExpenseRepo {
  ///
  Future<void> addExpense(ExpenseEntity expense);
}
