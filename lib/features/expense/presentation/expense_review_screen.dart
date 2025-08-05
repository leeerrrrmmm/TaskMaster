import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/core/widget/gradient_button_widget.dart';
import 'package:task_master/data/models/expense/expense_model.dart';
import 'package:task_master/features/expense/extension/expense_category_extension.dart';
import 'package:task_master/features/expense/widgets/expense_category_widget.dart';
import 'package:task_master/features/expense/widgets/expense_info_widget.dart';
import 'package:task_master/features/expense/widgets/header_widget.dart';
import 'package:task_master/features/expense/widgets/summary_expense_widget.dart';

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
                  const ExpenseListWidget(),
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

///
class ExpenseListWidget extends StatelessWidget {
  ///
  const ExpenseListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Center(child: Text('Пользователь не авторизован'));
    }

    final currentUid = currentUser.uid;

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: supabase.from('expenses').stream(primaryKey: ['id']),
      builder: (_, snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return const Center(child: CircularProgressIndicator());
        }

        final allTasks = snapshot.data ?? [];

        final filteredTasks = allTasks.where((taskJson) {
          final task = ExpenseModel.fromJson(taskJson);

          return task.userId == currentUid;
        }).toList();

        if (filteredTasks.isEmpty) {
          return const ExpenseInfoWidget(); // Нет задач
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredTasks.length,
          itemBuilder: (_, index) {
            final task = ExpenseModel.fromJson(filteredTasks[index]);

            return ExpenseCardWidget(data: task);
          },
        );
      },
    );
  }
}

///
class ExpenseCardWidget extends StatelessWidget {
  ///
  const ExpenseCardWidget({required this.data, super.key});

  ///
  final ExpenseModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        spacing: 10,
        children: [
          /// CREATED AT
          Row(children: [Image.asset('assets/images/rec.png')]),

          /// info Container
          Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.grey100,
              border: Border.all(color: AppColors.grey200),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Type',
                      style: TextStyle(fontSize: 14, color: AppColors.grey400),
                    ),
                    Text(
                      data.expenseCategory.label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Expsense',
                      style: TextStyle(fontSize: 14, color: AppColors.grey400),
                    ),
                    Text(
                      '\$${data.amount}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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
  }
}
