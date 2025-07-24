import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/core/widget/gradient_button_widget.dart';
import 'package:task_master/core/widget/text_form_widget.dart';
import 'package:task_master/features/leave/extension/leave_category_extension.dart';
import 'package:task_master/features/leave/extension/task_delegation_cat_extension.dart';
import 'package:task_master/features/leave/widgets/leave_and_task_delegation_widget.dart';

/// [SubmitLeave]
class SubmitLeave extends StatefulWidget {
  /// [SubmitLeave] constructor
  const SubmitLeave({super.key});

  @override
  State<SubmitLeave> createState() => _SubmitLeaveState();
}

class _SubmitLeaveState extends State<SubmitLeave> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  DateTime? _selectedDate;

  LeaveCategory? selectedLeave;
  TaskDelegationCat? selectedTaskDelegation;

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
          Container(
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
                    children: [
                      TextFormWidget(
                        text: 'Emergency Contact During Period',
                        hintText: 'Enter your number...',
                        controller: _phoneController,
                      ),
                      const SizedBox(height: 16),

                      /// 📅 Date picker field
                      GestureDetector(
                        onTap: () => _pickDate(context),
                        child: AbsorbPointer(
                          child: TextFormWidget(
                            text: 'Leave Start Date',
                            hintText: 'Pick a date...',
                            controller: _dateController,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      LeaveAndTaskDelegationWidget(
                        onTaskDelegationSelected: (leave) {
                          selectedTaskDelegation = leave;
                        },
                        onLeaveCatSelected: (taskDelegation) {
                          selectedLeave = taskDelegation;
                        },
                      ),
                    ],
                  ),
                ),
              ],
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
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // handle form submission
                      print('Phone: ${_phoneController.text}');
                      print('Date: ${_dateController.text}');
                      print('Leave: $selectedLeave');
                      print('Delegation: $selectedTaskDelegation');
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}

///
class TopHeadWidget extends StatelessWidget {
  ///
  const TopHeadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fill Leave Information',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(
          'Information about leave details',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.grey400,
          ),
        ),
      ],
    );
  }
}
