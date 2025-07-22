import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';

/// [LargeTextFormFieldWidget]
class LargeTextFormFieldWidget extends StatelessWidget {
  /// [LargeTextFormFieldWidget] constructor
  const LargeTextFormFieldWidget({
    required TextEditingController addressController,
    required String text,
    required String hintText,
    this.validator,
    super.key,
  }) : _addressController = addressController,
       _text = text,
       _hintText = hintText;

  final String _text;
  final String _hintText;
  final TextEditingController _addressController;

  ///
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_text),
        TextFormField(
          validator: validator,
          controller: _addressController,
          maxLength: 150,
          maxLines: 3,

          decoration: InputDecoration(
            hintText: _hintText,
            hintStyle: const TextStyle(color: AppColors.grey400),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.grey400),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }
}
