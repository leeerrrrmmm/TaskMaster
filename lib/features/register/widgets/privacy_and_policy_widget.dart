import 'package:flutter/material.dart';
import 'package:task_master/core/const/const.dart';
import 'package:task_master/core/theme/app_colors.dart';

/// [PrivacyAndPolicyWidget]
class PrivacyAndPolicyWidget extends StatelessWidget {
  /// [PrivacyAndPolicyWidget] constructor
  const PrivacyAndPolicyWidget({required this.onTap, super.key});

  ///
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.9,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              textAlign: TextAlign.center,
              'Terms & Conditions and\nPrivacy Policy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 26.0),
              child: SizedBox(
                height: 521,
                child: SingleChildScrollView(child: Text(Const.privacyPolicy)),
              ),
            ),
            // I AGREE
            InkWell(
              onTap: onTap,
              child: Container(
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
                child: const Center(
                  child: Text(
                    'I Agree',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // DECLINE
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.purple500),
                ),
                child: Center(
                  child: Text(
                    'Decline',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
