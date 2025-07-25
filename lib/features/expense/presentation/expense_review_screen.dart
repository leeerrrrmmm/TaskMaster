import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/features/expense/extension/expense_category_extension.dart';
import 'package:task_master/features/expense/service/bloc/expense_bloc.dart';
import 'package:task_master/features/expense/widgets/expense_info_widget.dart';
import 'package:task_master/features/expense/widgets/header_widget.dart';
import 'package:task_master/features/expense/widgets/summary_expense_widget.dart';
import 'package:task_master/features/expense/widgets/task_category_widget.dart';
import 'package:task_master/core/widget/gradient_button_widget.dart';

/// [ExpenseReviewScreen]
class ExpenseReviewScreen extends StatefulWidget {
  /// [ExpenseReviewScreen] constructor
  const ExpenseReviewScreen({super.key});

  @override
  State<ExpenseReviewScreen> createState() => _ExpenseReviewScreenState();
}

class _ExpenseReviewScreenState extends State<ExpenseReviewScreen> {
  int curPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      body: Stack(
        children: [
          const HeaderWidget(),
          Positioned.fill(
            top: 180,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 12.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SummaryExpenseWidget(),
                  const SizedBox(height: 16),
                  ExpenseCategoryWidget(
                    curPage: curPage,
                    onTap: (val) {
                      setState(() {
                        curPage = val;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<ExpenseBloc, ExpenseState>(
                    builder: (_, state) {
                      return state is ExpenseLoadedState &&
                              state.expenses.isNotEmpty
                          ? Column(
                              children: [
                                ...List.generate(state.expenses.length, (i) {
                                  final data = state.expenses[i];
                                  final createdAt = DateFormat(
                                    'd MMMM y',
                                  ).format(data.createdAt);

                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      children: [
                                        /// CREATED AT
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/rec.png',
                                            ),
                                            Text(
                                              createdAt,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),

                                        /// info Container
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          width: double.infinity,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: AppColors.grey100,
                                            border: Border.all(
                                              color: AppColors.grey200,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Type',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: AppColors.grey400,
                                                    ),
                                                  ),
                                                  Text(
                                                    data.expenseCategory.label,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Total Expsense',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: AppColors.grey400,
                                                    ),
                                                  ),
                                                  Text(
                                                    '\$${data.amount}',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            )
                          : const ExpenseInfoWidget();
                    },
                  ),
                  const SizedBox(height: 20),
                  GradientButtonWidget(
                    btnText: 'Submit Expense',
                    onTap: () => context.pushNamed('subExpense'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
