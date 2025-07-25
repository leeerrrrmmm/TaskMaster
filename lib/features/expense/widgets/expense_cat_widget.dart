import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/features/expense/extension/expense_category_extension.dart';

/// [ExpenseCatWidget]
class ExpenseCatWidget extends StatefulWidget {
  /// [ExpenseCatWidget] constructor
  const ExpenseCatWidget({super.key, this.onSelectedExpenseCategory});

  /// Callback when a priority is selected
  final void Function(ExpenseCategory?)? onSelectedExpenseCategory;

  @override
  State<ExpenseCatWidget> createState() => _ExpenseCatWidgetState();
}

class _ExpenseCatWidgetState extends State<ExpenseCatWidget> {
  ExpenseCategory? selectedExpenseCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Expense Category'),
        GestureDetector(
          onTap: () async {
            final result = await priorityModalSheet(
              context,
              selectedExpenseCategory,
            );
            if (result != null && result is ExpenseCategory) {
              setState(() {
                selectedExpenseCategory = result;
              });
              widget.onSelectedExpenseCategory?.call(result);
            }
          },
          child: Container(
            width: double.infinity,
            height: 58,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.grey400),
              color: AppColors.white,
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Image.asset('assets/profile/money.png'),
                const SizedBox(width: 16),
                Text(
                  selectedExpenseCategory?.label ?? 'Select Expense',
                  style: TextStyle(
                    color: selectedExpenseCategory != null
                        ? Colors.black
                        : AppColors.grey500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Priority Bottom Sheet
  Future<dynamic> priorityModalSheet(
    BuildContext context,
    ExpenseCategory? current,
  ) {
    ExpenseCategory? tempSelected = current;

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Select Priority',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ...ExpenseCategory.values.map((level) {
                    final isSelected = tempSelected == level;

                    return GestureDetector(
                      onTap: () {
                        setModalState(() {
                          tempSelected = level;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.purple500
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.purple500
                                : AppColors.grey400,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.grey500,
                                  width: 2,
                                ),
                                color: isSelected
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check,
                                      size: 14,
                                      color: AppColors.purple500,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              level.label,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: tempSelected != null
                            ? () => Navigator.pop(context, tempSelected)
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tempSelected != null
                              ? AppColors.purple500
                              : AppColors.grey400,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Select'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
