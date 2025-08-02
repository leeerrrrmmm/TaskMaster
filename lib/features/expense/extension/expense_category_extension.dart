///
extension ExpenseCategoryExtension on ExpenseCategory {
  ///
  String get label {
    switch (this) {
      case ExpenseCategory.bus:
        return 'Business Trip';
      case ExpenseCategory.office:
        return 'Office Supplies';
      case ExpenseCategory.meals:
        return 'Meals and Entertainment';
      case ExpenseCategory.prof:
        return 'Professional Development';
      case ExpenseCategory.home:
        return 'Home Office Expenses';
      case ExpenseCategory.mile:
        return 'Mileage Reimbursement';
      case ExpenseCategory.misc:
        return 'Miscellaneous Expenses';
      case ExpenseCategory.unknown:
        return 'Unknown';
    }
  }
}

///
enum ExpenseCategory {
  ///
  bus,

  ///
  office,

  ///
  meals,

  ///
  prof,

  ///
  home,

  ///
  mile,

  ///
  misc,

  ///
  unknown,
}
