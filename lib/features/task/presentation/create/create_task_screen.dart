import 'dart:developer';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/core/widget/border_btn_widget.dart';
import 'package:task_master/features/task/data/model/task_model.dart';
import 'package:task_master/features/task/extensions/diff_level_extension.dart';
import 'package:task_master/features/task/extensions/prior_level_extension.dart';
import 'package:task_master/features/task/service/bloc/task_bloc.dart';
import 'package:task_master/features/task/service/bloc/task_event.dart';
import 'package:task_master/features/task/service/bloc/task_state.dart';
import 'package:task_master/features/task/widgets/prior_and_diff_level_widget.dart';
import 'package:task_master/core/widget/gradient_button_widget.dart';
import 'package:task_master/core/widget/large_text_form_field_widget.dart';
import 'package:task_master/core/widget/text_form_widget.dart';

/// [CreateTaskScreen]
class CreateTaskScreen extends StatefulWidget {
  /// [CreateTaskScreen] constructor
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _memberController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// значения из PriorAndDiffLevelWidget
  PriorityLevel? selectedPriority;
  DifficultyLevel? selectedDifficulty;

  void _onCreateTask() {
    final isFormValid = _formKey.currentState?.validate() ?? false;

    final bool hasPriority = selectedPriority != null;
    final bool hasDifficulty = selectedDifficulty != null;

    if (isFormValid && hasPriority && hasDifficulty) {
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
                        'Create New Task',
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
                      BlocBuilder<TaskBloc, TaskState>(
                        builder: (context, _) {
                          return GradientButtonWidget(
                            btnText: 'Yes, Proceed Now',
                            onTap: () {
                              final bloc = context.read<TaskBloc>();

                              bloc.add(
                                AddTask(
                                  task: TaskModel(
                                    id: DateTime.now().millisecondsSinceEpoch
                                        .toString(),
                                    title: _titleController.text,
                                    description: _descriptionController.text,
                                    assignedTo: _memberController.text,
                                    priority: selectedPriority,
                                    difficulty: selectedDifficulty,
                                    createdAt: DateTime.now(),
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                              context.goNamed('task');

                              context.pushNamed('task');
                            },
                          );
                        },
                      ),

                      BorderBtnWidget(
                        btnText: 'No, Let me check',
                        onTap: () {
                          //TODO
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
                    child: Image.asset('assets/profile/creaTask.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      log('❌ Ошибка: не все поля заполнены');
      if (!isFormValid) {
        log('→ Проверьте текстовые поля');
      }
      if (!hasPriority) {
        log('→ Приоритет не выбран');
      }
      if (!hasDifficulty) {
        log('→ Сложность не выбрана');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey300,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.purple50,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.purple400,
            ),
          ),
        ),
        title: const Text(
          'Create New Task',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Attachment'),
                    const Text(
                      'Format should be in .pdf .jpeg .png less than 5MB',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        3,
                        (_) => SizedBox(
                          height: 100,
                          width: 106,
                          child: GestureDetector(
                            onTap: () {
                              // TODO: image picker
                            },
                            child: DottedBorder(
                              options: const RoundedRectDottedBorderOptions(
                                radius: Radius.circular(8),
                                color: AppColors.purple500,
                              ),
                              child: Center(
                                child: Image.asset('assets/images/load.png'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// --- Form
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormWidget(
                            text: 'Task Title',
                            hintText: 'Enter Task Title',
                            controller: _titleController,
                            prefixIcon: Image.asset(
                              'assets/profile/scroll.png',
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Enter a title'
                                : null,
                          ),
                          const SizedBox(height: 16),
                          LargeTextFormFieldWidget(
                            addressController: _descriptionController,
                            text: 'Task Description',
                            hintText: 'Enter Task Description',
                            validator: (value) => value == null || value.isEmpty
                                ? 'Enter description'
                                : null,
                          ),
                          TextFormWidget(
                            text: 'Assign To',
                            hintText: 'member email...',
                            controller: _memberController,
                            prefixIcon: Image.asset(
                              'assets/log_reg_images/id.png',
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Enter email'
                                : null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// --- Priority & Difficulty
                    PriorAndDiffLevelWidget(
                      onPrioritySelected: (priority) {
                        selectedPriority = priority;
                      },
                      onDifficultySelected: (difficulty) {
                        selectedDifficulty = difficulty;
                      },
                    ),
                    const SizedBox(height: 10), // Отступ под кнопку
                  ],
                ),
              ),
            ),
          ),

          /// --- Bottom Button
          Container(
            height: 100,
            color: Colors.white,
            child: Center(
              child: GradientButtonWidget(
                btnText: 'Create Task',
                onTap: _onCreateTask,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
