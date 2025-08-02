import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/features/task/extensions/difficulty_level_extension.dart';
import 'package:task_master/features/task/extensions/priority_level_extension.dart';

/// [PriorAndDiffLevelWidget]
class PriorAndDiffLevelWidget extends StatefulWidget {
  /// [PriorAndDiffLevelWidget] constructor
  const PriorAndDiffLevelWidget({
    super.key,
    this.onPrioritySelected,
    this.onDifficultySelected,
  });

  /// Callback when a priority is selected
  final void Function(PriorityLevel?)? onPrioritySelected;

  /// Callback when a difficulty is selected
  final void Function(DifficultyLevel?)? onDifficultySelected;

  @override
  State<PriorAndDiffLevelWidget> createState() =>
      _PriorAndDiffLevelWidgetState();
}

class _PriorAndDiffLevelWidgetState extends State<PriorAndDiffLevelWidget> {
  PriorityLevel? selectedPriority;
  DifficultyLevel? selectedDifficulty;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Priority'),
        GestureDetector(
          onTap: () async {
            final result = await priorityModalSheet(context, selectedPriority);
            if (result != null && result is PriorityLevel) {
              setState(() {
                selectedPriority = result;
              });
              widget.onPrioritySelected?.call(result);
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
                  selectedPriority?.label ?? 'Select Priority',
                  style: TextStyle(
                    color: selectedPriority != null
                        ? Colors.black
                        : AppColors.grey500,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Difficulty'),
        GestureDetector(
          onTap: () async {
            final result = await difficultyLevelModalSheet(
              context,
              selectedDifficulty,
            );
            if (result != null && result is DifficultyLevel) {
              setState(() {
                selectedDifficulty = result;
              });
              widget.onDifficultySelected?.call(result);
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
                  selectedDifficulty?.label ?? 'Select Difficulty',
                  style: TextStyle(
                    color: selectedDifficulty != null
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
    PriorityLevel? current,
  ) {
    PriorityLevel? tempSelected = current;

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
                  ...PriorityLevel.values.map((level) {
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
  Future<dynamic> difficultyLevelModalSheet(
    BuildContext context,
    DifficultyLevel? current,
  ) {
    DifficultyLevel? tempSelected = current;

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
                  ...DifficultyLevel.values.map((level) {
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
