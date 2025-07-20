import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';

/// [LargeTextFormFieldWidget]
class LargeTextFormFieldWidget extends StatelessWidget {
  /// [LargeTextFormFieldWidget] constructor
  const LargeTextFormFieldWidget({
    required TextEditingController addressController,
    required String text,
    required String hintText,
    super.key,
  }) : _addressController = addressController,
       _text = text,
       _hintText = hintText;

  final String _text;
  final String _hintText;
  final TextEditingController _addressController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_text),
        Container(
          width: double.infinity,
          height: 130,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey400),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: _addressController,
            maxLength: 150,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: _hintText,
              hintStyle: const TextStyle(color: AppColors.grey400),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
      ],
    );
  }
}
