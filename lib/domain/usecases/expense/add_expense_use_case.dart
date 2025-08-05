import 'package:task_master/domain/entity/expense/expense_entity.dart';
import 'package:task_master/domain/repository/expense_repo.dart';

///
class AddExpenseUseCase {
  ///
  final ExpenseRepo expenseRepo;

  ///
  AddExpenseUseCase({required this.expenseRepo});

  ///
  Future<void> call(ExpenseEntity expense) => expenseRepo.addExpense(expense);
}
