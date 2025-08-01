import 'package:task_master/features/expense/extension/expense_category_extension.dart';

///
class ExpenseModel {
  ///
  final String id;

  ///
  final ExpenseCategory expenseCategory;

  ///
  final String amount;

  ///
  final String description;

  ///
  final DateTime tranDate;

  ///
  final DateTime createdAt;

  ///
  const ExpenseModel({
    required this.id,
    required this.expenseCategory,
    required this.amount,
    required this.description,
    required this.tranDate,
    required this.createdAt,
  });

  ///
  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
    id: DateTime.now().toIso8601String(),
    expenseCategory: ExpenseCategory.values.byName(
      json['expenseCategory'].toString(),
    ),
    amount: json['amount'].toString(),
    description: json['description'].toString(),
    tranDate: DateTime.parse(json['tranDate'].toString()),
    createdAt: DateTime.parse(json['createdAt'].toString()),
  );
}
