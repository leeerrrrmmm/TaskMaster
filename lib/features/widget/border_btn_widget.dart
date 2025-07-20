import 'package:flutter/material.dart';

/// [BorderBtnWidget]
class BorderBtnWidget extends StatelessWidget {
  /// [BorderBtnWidget] constructor
  const BorderBtnWidget({
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
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            btnText,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
