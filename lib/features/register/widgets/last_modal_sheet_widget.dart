import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/core/const/const.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/core/widget/border_btn_widget.dart';
import 'package:task_master/core/widget/gradient_button_widget.dart';

/// [LastModalSheetWidget]
class LastModalSheetWidget extends StatelessWidget {
  /// [LastModalSheetWidget] constructor
  const LastModalSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.none,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 32),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 32.0, bottom: 16.0),
                  child: Text(
                    'Welcome To Work Mate!',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Text(textAlign: TextAlign.center, Const.welcomeMate),

                Padding(
                  padding: const EdgeInsets.only(top: 38.0, bottom: 30.0),
                  child: GradientButtonWidget(
                    btnText: 'Set Up My Profile',
                    onTap: () => context.goNamed('setUpProfile'),
                  ),
                ),

                BorderBtnWidget(
                  btnText: 'Explore The App First',
                  onTap: () => context.goNamed('main'),
                ),
              ],
            ),
          ),

          // Top Image
          Positioned(
            top: -50,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                height: 100,
                child: Image.asset('assets/log_reg_images/welcome.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
