import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';

/// [DottedBoxWidget]
class DottedBoxWidget extends StatelessWidget {
  /// [DottedBoxWidget] constructor
  const DottedBoxWidget({required this.onTap, super.key});

  ///
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DottedBorder(
        options: const RoundedRectDottedBorderOptions(
          radius: Radius.circular(10),
          dashPattern: [10, 5],
          strokeWidth: 2,
          padding: EdgeInsets.all(16),
          color: AppColors.purple500,
        ),
        child: Container(
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Center(child: Image.asset('assets/profile/image.png')),
        ),
      ),
    );
  }
}
