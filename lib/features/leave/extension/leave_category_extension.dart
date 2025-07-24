///
enum LeaveCategory {
  ///
  sick,

  ///
  annual,

  ///
  mat,

  ///
  ber,

  ///
  personal,

  ///
  jury,

  ///
  compassionate,
}

///
extension LeaveCategoryExtension on LeaveCategory {
  ///
  String get label {
    switch (this) {
      case LeaveCategory.sick:
        return 'Sick Leave';
      case LeaveCategory.annual:
        return 'Annual Leave/Vacation Leave';
      case LeaveCategory.mat:
        return 'Maternity/Paternity Leave';
      case LeaveCategory.ber:
        return 'Bereavement Leave';
      case LeaveCategory.personal:
        return 'Personal Leave';
      case LeaveCategory.jury:
        return 'Personal Leave';
      case LeaveCategory.compassionate:
        return 'Compassionate Leave';
    }
  }
}
