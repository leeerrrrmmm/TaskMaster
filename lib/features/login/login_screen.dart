import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/core/widget/text_form_widget.dart';

/// [LoginScreen]
class LoginScreen extends StatefulWidget {
  /// [LoginScreen] constructor

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ///
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // BACKGROUND
          Container(
            height: 560,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.center,
                colors: [AppColors.purple900, AppColors.white],
              ),
            ),
          ),
          // CONTAINER
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 636,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(32),
                  topLeft: Radius.circular(32),
                ),
              ),
              child: LoginInfo(
                emailController: emailController,
                passwordController: passwordController,
                obscure: obscure,
                onPressed: () => setState(() {
                  obscure = !obscure;
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// [LoginInfo]
class LoginInfo extends StatelessWidget {
  /// [LoginInfo] constructor
  const LoginInfo({
    required this.emailController,
    required this.passwordController,
    required this.obscure,
    this.onPressed,
    super.key,
  });

  ///
  final TextEditingController emailController;

  ///
  final TextEditingController passwordController;

  ///
  final bool obscure;

  ///
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        children: [
          Text(
            'Sign In',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const Text(
            'Sign in to my account',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.grey600,
            ),
          ),
          // FORM
          Form(
            child: Column(
              children: [
                TextFormWidget(
                  text: 'Email',
                  hintText: 'My Email',
                  controller: emailController,
                  prefixIcon: Image.asset('assets/log_reg_images/email.png'),
                ),
                const SizedBox(height: 24),
                TextFormWidget(
                  text: 'Password',
                  hintText: 'My Password',
                  controller: passwordController,
                  obscure: obscure,
                  onPressed: onPressed,
                  prefixIcon: Image.asset('assets/log_reg_images/pas.png'),
                ),
                // REMEMBER ME & FORGOT PASSWORD
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (_) {
                              //TODO
                            },
                          ),
                          const Text('Remember Me'),
                        ],
                      ),
                      TextButton(
                        onPressed: () => context.pushNamed('forgot'),
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(color: AppColors.purple400),
                        ),
                      ),
                    ],
                  ),
                ),

                /// SIGN IN BTN
                InkWell(
                  onTap: () {
                    ///TODO
                  },
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.purple500,
                          AppColors.purple600,
                          AppColors.purple700,
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                // ------ OR -----
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        color: AppColors.grey400,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 32.0,
                      ),
                      child: Text(
                        'OR',
                        style: TextStyle(color: AppColors.grey400),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        color: AppColors.grey400,
                      ),
                    ),
                  ],
                ),

                // BUTTONS SIGN IN WITH ...
                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.purple500),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/log_reg_images/id.png'),
                      const SizedBox(width: 10),
                      const Text(
                        'Sign in With Empkoyee ID',
                        style: TextStyle(color: AppColors.purple500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.purple500),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/log_reg_images/phone.png'),
                      const SizedBox(width: 10),
                      const Text(
                        'Sign in With Phone',
                        style: TextStyle(color: AppColors.purple500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // DON'T HAVE AN ACCOUNT?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                      onPressed: () => context.goNamed('register'),
                      child: const Text(
                        ' Sign Up Here',
                        style: TextStyle(
                          color: AppColors.purple700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
