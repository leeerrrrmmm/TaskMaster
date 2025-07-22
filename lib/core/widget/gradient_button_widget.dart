import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';

/// [GradientButtonWidget]
class GradientButtonWidget extends StatelessWidget {
  /// [GradientButtonWidget] constructor
  const GradientButtonWidget({
    required this.btnText,
    required this.onTap,
    super.key,
  });

  ///
  final String btnText;

  ///
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32.0),
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.purple500,
              AppColors.purple600,
              AppColors.purple700,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            btnText,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
