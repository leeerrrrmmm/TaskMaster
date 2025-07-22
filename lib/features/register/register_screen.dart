import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/features/register/widgets/last_modal_sheet_widget.dart';
import 'package:task_master/features/register/widgets/otp_widget.dart';
import 'package:task_master/features/register/widgets/privacy_and_policy_widget.dart';
import 'package:task_master/core/widget/gradient_button_widget.dart';
import 'package:task_master/core/widget/text_form_widget.dart';

/// [RegisterScreen]
class RegisterScreen extends StatefulWidget {
  /// [RegisterScreen] constructor

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController pasController = TextEditingController();
  final TextEditingController checkPasController = TextEditingController();

  bool obscure = true;

  bool iAgreePressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TopInfo(),
            CenterForm(
              formKey: _formKey,
              emailController: emailController,
              phoneController: phoneController,
              companyController: companyController,
              passController: pasController,
              checkPassController: checkPasController,
              obscure: obscure,
              onTap: () => setState(() {
                obscure = !obscure;
              }),
            ),
            // SIGN UP BUTTON
            GradientButtonWidget(
              btnText: 'Sign In',
              onTap: () => showModalSheet(context),
            ),

            // ALREADY HAVE AN ACCOUNT?
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                children: [
                  const TextSpan(text: 'Already have an account?'),
                  TextSpan(
                    text: ' Sign in here',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.goNamed('login');
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => PrivacyAndPolicyWidget(
        onTap: () async {
          Navigator.pop(context);

          setState(() {
            iAgreePressed = true;
          });
          await Future.delayed(const Duration(milliseconds: 400));
          if (!mounted) return;
          await showOtpModalSheet();
        },
      ),
    );
  }

  Future<void> showOtpModalSheet() async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.transparent,
      builder: (_) {
        return OtpWidget(userEmail: emailController.text);
      },
    );

    if (result ?? false == true) {
      await Future.delayed(const Duration(milliseconds: 400));
      showLastModalSheet();
    }
  }

  void showLastModalSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return const LastModalSheetWidget();
      },
    );
  }
}

/// [TopInfo]
class TopInfo extends StatelessWidget {
  /// [TopInfo] constructor
  const TopInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/log_reg_images/logo.png'),
        const Text(
          'Work Mate',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          'Register Useing Yoour Credentials',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

/// [CenterForm]
class CenterForm extends StatelessWidget {
  /// [CenterForm] constructor
  const CenterForm({
    required this.formKey,
    required this.emailController,
    required this.phoneController,
    required this.companyController,
    required this.passController,
    required this.checkPassController,
    required this.obscure,
    this.onTap,
    super.key,
  });

  ///
  final GlobalKey<FormState> formKey;

  ///
  final TextEditingController emailController;

  ///
  final TextEditingController phoneController;

  ///
  final TextEditingController companyController;

  ///
  final TextEditingController passController;

  ///
  final TextEditingController checkPassController;

  ///
  final bool obscure;

  ///
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            TextFormWidget(
              prefixIcon: Image.asset('assets/log_reg_images/email.png'),
              text: 'Email',
              hintText: 'Enter Your Email',
              controller: emailController,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextFormWidget(
                text: 'Phone Number',
                hintText: 'Enter Your Phone Number',
                controller: phoneController,
              ),
            ),

            TextFormWidget(
              prefixIcon: Image.asset('assets/log_reg_images/email.png'),
              text: 'Company ID',
              hintText: 'Enter Your Company ID',
              controller: companyController,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextFormWidget(
                prefixIcon: Image.asset('assets/log_reg_images/pas.png'),
                text: 'Password',
                hintText: 'Enter Your Password',
                controller: passController,
                obscure: obscure,
                onPressed: onTap,
              ),
            ),

            TextFormWidget(
              prefixIcon: Image.asset('assets/log_reg_images/pas.png'),
              text: 'Confirm Password',
              hintText: 'Confirm Your Password',
              controller: checkPassController,
              obscure: obscure,
              onPressed: onTap,
            ),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (_) {
                    // TODO
                  },
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 12,
                    ),
                    children: [
                      const TextSpan(text: 'I agree with'),
                      TextSpan(
                        text: ' terms & conditions ',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            log('User was clicked an terms & conditions');
                          },
                      ),
                      const TextSpan(text: 'and'),
                      TextSpan(
                        text: ' privacy and policy',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
