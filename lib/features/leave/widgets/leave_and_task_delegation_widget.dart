import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/features/leave/extension/leave_category_extension.dart';
import 'package:task_master/features/leave/extension/task_delegation_cat_extension.dart';

/// [LeaveAndTaskDelegationWidget]
class LeaveAndTaskDelegationWidget extends StatefulWidget {
  /// [LeaveAndTaskDelegationWidget] constructor
  const LeaveAndTaskDelegationWidget({
    super.key,
    this.onLeaveCatSelected,
    this.onTaskDelegationSelected,
  });

  /// Callback when a priority is selected
  final void Function(LeaveCategory?)? onLeaveCatSelected;

  /// Callback when a difficulty is selected
  final void Function(TaskDelegationCat?)? onTaskDelegationSelected;

  @override
  State<LeaveAndTaskDelegationWidget> createState() =>
      _LeaveAndTaskDelegationWidgetState();
}

class _LeaveAndTaskDelegationWidgetState
    extends State<LeaveAndTaskDelegationWidget> {
  LeaveCategory? selectedLeave;
  TaskDelegationCat? selectedTaskDelegation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Leave Category'),
        GestureDetector(
          onTap: () async {
            final result = await priorityModalSheet(context, selectedLeave);
            if (result != null && result is LeaveCategory) {
              setState(() {
                selectedLeave = result;
              });
              widget.onLeaveCatSelected?.call(result);
            }
          },
          child: Container(
            width: double.infinity,
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.grey400),
              color: AppColors.white,
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Image.asset('assets/profile/money.png'),
                const SizedBox(width: 16),
                Text(
                  selectedLeave?.label ?? 'Select Leave',
                  style: TextStyle(
                    color: selectedLeave != null
                        ? Colors.black
                        : AppColors.grey500,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Task Delegation'),
        GestureDetector(
          onTap: () async {
            final result = await taskDelegationCatModalSheet(
              context,
              selectedTaskDelegation,
            );
            if (result != null && result is TaskDelegationCat) {
              setState(() {
                selectedTaskDelegation = result;
              });
              widget.onTaskDelegationSelected?.call(result);
            }
          },
          child: Container(
            width: double.infinity,
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.grey400),
              color: AppColors.white,
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Image.asset('assets/profile/crown.png'),
                const SizedBox(width: 16),
                Text(
                  selectedTaskDelegation?.label ?? 'Select Task Delegation',
                  style: TextStyle(
                    color: selectedTaskDelegation != null
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
    LeaveCategory? current,
  ) {
    LeaveCategory? tempSelected = current;

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
                  ...LeaveCategory.values.map((level) {
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

  // Difficulty Bottom Sheet
  Future<dynamic> taskDelegationCatModalSheet(
    BuildContext context,
    TaskDelegationCat? current,
  ) {
    TaskDelegationCat? tempSelected = current;

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
                    'Select Difficulty',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ...TaskDelegationCat.values.map((level) {
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
