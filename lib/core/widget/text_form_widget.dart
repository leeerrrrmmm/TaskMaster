import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';

/// [TextFormWidget] to LoginScreen & RegisterScreen
class TextFormWidget extends StatelessWidget {
  /// Counstructor [TextFormWidget]
  const TextFormWidget({
    required this.text,
    required this.hintText,
    required this.controller,
    this.validator,
    this.onPressed,
    this.obscure,
    this.prefixIcon,
    super.key,
  });

  ///
  final String text;

  ///
  final String hintText;

  ///
  final TextEditingController controller;

  ///
  final Widget? prefixIcon;

  ///
  final bool? obscure;

  ///
  final void Function()? onPressed;

  ///
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        TextFormField(
          validator: validator,
          obscureText: obscure ?? false,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            hintStyle: const TextStyle(color: AppColors.grey400),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.grey400),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.grey400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.purple500),
            ),
            suffixIcon: obscure != null
                ? IconButton(
                    onPressed: onPressed,
                    icon: Icon(
                      obscure ?? false
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.purple400,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
