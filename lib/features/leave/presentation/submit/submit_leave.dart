import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/core/widget/border_btn_widget.dart';
import 'package:task_master/core/widget/gradient_button_widget.dart';
import 'package:task_master/core/widget/large_text_form_field_widget.dart';
import 'package:task_master/core/widget/text_form_widget.dart';
import 'package:task_master/features/leave/data/model/leave_model.dart';
import 'package:task_master/features/leave/extension/leave_category_extension.dart';
import 'package:task_master/features/leave/extension/task_delegation_cat_extension.dart';
import 'package:task_master/features/leave/service/bloc/leave_bloc.dart';
import 'package:task_master/features/leave/widgets/leave_and_task_delegation_widget.dart';
import 'package:task_master/features/leave/widgets/top_head_widget.dart';

/// [SubmitLeave]
class SubmitLeave extends StatefulWidget {
  /// [SubmitLeave] constructor
  const SubmitLeave({super.key});

  @override
  State<SubmitLeave> createState() => _SubmitLeaveState();
}

class _SubmitLeaveState extends State<SubmitLeave> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();

  DateTime? _selectedDate;

  LeaveCategory? selectedLeave;
  TaskDelegationCat? selectedTaskDelegation;

  void onCreateTask() {
    final formState = _formKey.currentState;
    final isFormValid = formState?.validate() ?? false;

    final hasLeave = selectedLeave != null;
    final hasTaskDelegation = selectedTaskDelegation != null;

    if (!isFormValid || !hasLeave || !hasTaskDelegation) {
      log('❌ Ошибка: не все поля заполнены');
      if (!isFormValid) log('→ Проверьте текстовые поля');
      if (!hasLeave) log('→ Приоритет не выбран');
      if (!hasTaskDelegation) log('→ Сложность не выбрана');

      return;
    }

    try {
      final startLeave = DateFormat(
        'dd/MM/yyyy',
      ).parseStrict(_startController.text);
      final endLeave = DateFormat(
        'dd/MM/yyyy',
      ).parseStrict(_endController.text);

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
                        'Submit Leave',
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
                      BlocBuilder<LeaveBloc, LeaveState>(
                        builder: (context, _) {
                          return GradientButtonWidget(
                            btnText: 'Yes, Proceed Now',
                            onTap: () {
                              final bloc = context.read<LeaveBloc>();

                              bloc.add(
                                AddLeave(
                                  LeaveModel(
                                    id: DateTime.now().millisecondsSinceEpoch
                                        .toString(),
                                    number: _phoneController.text,
                                    leaveCategory:
                                        selectedLeave ?? LeaveCategory.unknown,
                                    taskDelegationCategory:
                                        selectedTaskDelegation ??
                                        TaskDelegationCat.unknown,
                                    startLeave: startLeave,
                                    endLeave: endLeave,
                                    description: _descriptionController.text,
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
          'Submit Leave',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 120),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopHeadWidget(),
                  Form(
                    key: _formKey,
                    child: Column(
                      spacing: 3,
                      children: [
                        TextFormWidget(
                          text: 'Emergency Contact During Period',
                          hintText: 'Enter your number...',
                          controller: _phoneController,
                          prefixIcon: Image.asset('assets/images/notif.png'),
                          validator: (val) {
                            if (val?.isEmpty ?? true) return 'Enter number';
                          },
                        ),

                        /// 📅 Date picker field
                        GestureDetector(
                          onTap: () => _pickDate(context, _startController),
                          child: AbsorbPointer(
                            child: TextFormWidget(
                              validator: (date) {
                                if (date?.isEmpty ?? true) {
                                  return 'Select a Start Leave Date';
                                }
                              },
                              text: 'Leave Start Date',
                              hintText: 'Pick a date...',
                              controller: _startController,
                              prefixIcon: Image.asset(
                                'assets/profile/calendar.png',
                              ),
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () => _pickDate(context, _endController),
                          child: AbsorbPointer(
                            child: TextFormWidget(
                              text: 'Leave End Date',
                              hintText: 'Pick a date...',
                              controller: _endController,
                              prefixIcon: Image.asset(
                                'assets/profile/calendar.png',
                              ),
                            ),
                          ),
                        ),

                        LeaveAndTaskDelegationWidget(
                          onTaskDelegationSelected: (leave) {
                            selectedTaskDelegation = leave;
                          },
                          onLeaveCatSelected: (taskDelegation) {
                            selectedLeave = taskDelegation;
                          },
                        ),
                        LargeTextFormFieldWidget(
                          addressController: _descriptionController,
                          text: 'Leave Description',
                          hintText: 'Enter Leave Description',
                          validator: (date) {
                            if (date?.isEmpty ?? true) {
                              return 'Enter description...';
                            }
                          },
                        ),
                      ],
                    ),
                  ),
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
              decoration: const BoxDecoration(color: Colors.white),
              child: Center(
                child: GradientButtonWidget(
                  btnText: 'Submit Now',
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

  @override
  void dispose() {
    _phoneController.dispose();
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }
}
