import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/core/widget/border_btn_widget.dart';
import 'package:task_master/core/widget/gradient_button_widget.dart';
import 'package:task_master/core/widget/large_text_form_field_widget.dart';
import 'package:task_master/core/widget/text_form_widget.dart';
import 'package:task_master/features/expense/data/model/expense_model.dart';
import 'package:task_master/features/expense/extension/expense_category_extension.dart';
import 'package:task_master/features/expense/service/bloc/expense_bloc.dart';
import 'package:task_master/features/expense/widgets/expense_cat_widget.dart';

/// [SubmitExpense]
class SubmitExpense extends StatefulWidget {
  /// [SubmitExpense] constructor
  const SubmitExpense({super.key});

  @override
  State<SubmitExpense> createState() => _SubmitExpenseState();
}

class _SubmitExpenseState extends State<SubmitExpense> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime? _selectedDate;

  ExpenseCategory? selectedExpenseCategory;

  void onCreateTask() {
    final formState = _formKey.currentState;
    final isFormValid = formState?.validate() ?? false;

    final hasLeave = selectedExpenseCategory != null;

    if (!isFormValid || !hasLeave) {
      log('❌ Ошибка: не все поля заполнены');
      if (!isFormValid) log('→ Проверьте текстовые поля');
      if (!hasLeave) log('→ Приоритет не выбран');

      return;
    }

    try {
      showModalBottomSheet(
        context: context,
        builder: (_) => ClipRRect(
          clipBehavior: Clip.none,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 328,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                    left: 31.0,
                    right: 31.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Submit Expense',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        '''Double-check your task details to ensure everything is correct. Do you want to proceed?''',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.grey400,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      BlocBuilder<ExpenseBloc, ExpenseState>(
                        builder: (context, _) {
                          return GradientButtonWidget(
                            btnText: 'Yes, Proceed Now',
                            onTap: () {
                              final bloc = context.read<ExpenseBloc>();

                              final tranDate = DateFormat(
                                'dd/MM/yyyy',
                              ).parseStrict(_dateController.text);
                              bloc.add(
                                AddExpenseEvent(
                                  ExpenseModel(
                                    id: DateTime.now().millisecondsSinceEpoch
                                        .toString(),

                                    description: _descriptionController.text,
                                    expenseCategory:
                                        selectedExpenseCategory ??
                                        ExpenseCategory.unknown,
                                    amount: _amountController.text,
                                    tranDate: tranDate,
                                    createdAt: DateTime.now(),
                                  ),
                                ),
                              );

                              Navigator.pop(context);
                              context.goNamed('bottom');
                            },
                          );
                        },
                      ),
                      BorderBtnWidget(
                        btnText: 'No, Let me check',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -50,
                left: 0,
                right: 0,
                child: Center(
                  child: SizedBox(
                    height: 100,
                    child: Image.asset('assets/images/subLeave.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      log('❌ Ошибка при парсинге даты: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, выберите корректные даты')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      appBar: AppBar(
        title: const Text(
          'Submit Expense',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Flexible(
              child: Column(
                children: [
                  Image.asset('assets/images/banner.png'),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      spacing: 10,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FillClaimInfoWidget(),
                        const DottedImgLoaderWidget(),
                        Form(
                          key: _formKey,
                          child: Column(
                            spacing: 10,
                            children: [
                              ExpenseCatWidget(
                                onSelectedExpenseCategory: (cat) {
                                  selectedExpenseCategory = cat;
                                },
                              ),

                              /// 📅 Date picker field
                              GestureDetector(
                                onTap: () =>
                                    _pickDate(context, _dateController),
                                child: AbsorbPointer(
                                  child: TextFormWidget(
                                    validator: (date) {
                                      if (date == null || date.isEmpty) {
                                        return 'Select a Start Date';
                                      }
                                      try {
                                        DateFormat(
                                          'dd/MM/yyyy',
                                        ).parseStrict(date);
                                      } catch (_) {
                                        return 'Enter date as dd/MM/yyyy';
                                      }

                                      return null;
                                    },
                                    text: 'Leave Start Date',
                                    hintText: 'Pick a date...',
                                    controller: _dateController,
                                    prefixIcon: Image.asset(
                                      'assets/profile/calendar.png',
                                    ),
                                  ),
                                ),
                              ),

                              TextFormWidget(
                                validator: (amount) {
                                  if (amount == null || amount.isEmpty) {
                                    return 'Enter an amount';
                                  }
                                  final parsed = double.tryParse(amount);
                                  if (parsed == null || parsed <= 0) {
                                    return 'Enter a valid amount';
                                  }

                                  return null;
                                },
                                text: r'Expense Amount ($USD)',
                                hintText: 'Enter Amount',
                                controller: _amountController,
                              ),

                              LargeTextFormFieldWidget(
                                addressController: _descriptionController,
                                text: 'Expense Description',
                                hintText: 'Enter Expense Description',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 100,
              color: Colors.white,
              child: Center(
                child: GradientButtonWidget(
                  btnText: 'Submit Expense',
                  onTap: onCreateTask,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        controller.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
}

class DottedImgLoaderWidget extends StatelessWidget {
  const DottedImgLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      color: AppColors.purple50,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(12),
          dashPattern: [3, 4],
          color: AppColors.purple600,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/images/im.png'),
              const Column(
                children: [
                  Text(
                    'Upload Claim Document',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.purple500,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '''Format should be in .pdf .jpeg .png less than 5MB''',
                    style: TextStyle(fontSize: 14, color: AppColors.grey500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FillClaimInfoWidget extends StatelessWidget {
  const FillClaimInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fill Claim Information',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(
          'Information about claim details',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.grey400,
          ),
        ),
      ],
    );
  }
}
