import 'package:task_master/domain/entity/expense/expense_entity.dart';
import 'package:task_master/features/expense/extension/expense_category_extension.dart';

///
class ExpenseModel extends ExpenseEntity {
  ///
  const ExpenseModel({
    required super.id,
    required super.userId,
    required super.expenseCategory,
    required super.amount,
    required super.description,
    required super.tranDate,
  });

  ///
  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
    id: json['id'].toString(),
    expenseCategory: ExpenseCategory.values.byName(
      json['expense_category'].toString(),
    ),
    userId: json['user_id'].toString(),
    amount: json['amount'].toString(),
    description: json['description'].toString(),
    tranDate: DateTime.parse(json['tran_date'].toString()),
  );

  ///
  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'expense_category': expenseCategory.name,
    'amount': amount,
    'description': description,
    'tran_date': tranDate.toIso8601String(),
  };
}
