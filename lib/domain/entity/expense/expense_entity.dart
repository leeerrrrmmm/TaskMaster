import 'package:task_master/features/expense/extension/expense_category_extension.dart';

///
class ExpenseEntity {
  ///
  final String id;

  ///
  final String userId;

  ///
  final ExpenseCategory expenseCategory;

  ///
  final String amount;

  ///
  final String description;

  ///
  final DateTime tranDate;

  ///
  const ExpenseEntity({
    required this.id,
    required this.userId,
    required this.expenseCategory,
    required this.amount,
    required this.description,
    required this.tranDate,
  });
}
