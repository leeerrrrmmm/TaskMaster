import 'package:email_otp/email_otp.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_master/core/theme/app_colors.dart';

/// [OtpWidget]
class OtpWidget extends StatefulWidget {
  /// [OtpWidget] constructor
  const OtpWidget({required this.userEmail, super.key});

  ///
  final String userEmail;

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  static const lenForOtp = 6;

  final List<TextEditingController> _controllers = List.generate(
    lenForOtp,
    (_) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(
    lenForOtp,
    (_) => FocusNode(),
  );

  @override
  void initState() {
    super.initState();

    EmailOTP.config(
      otpLength: lenForOtp,
      appName: 'Work Mate',
      appEmail: 'workmateotpsender@gmail.com',
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final bool isSent = await EmailOTP.sendOTP(email: widget.userEmail);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isSent ? 'Code was sent to your email' : 'Failed to send code',
            ),
          ),
        );
      }
    });
  }

  void otpChanget(int index, String value) {
    if (value.isEmpty) return;

    if (index < lenForOtp - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else {
      FocusScope.of(context).unfocus(); // Hide keyboard after last digit
    }
  }

  Future<void> _verifyOtp() async {
    final code = _controllers.map((c) => c.text).join();

    if (code.length != lenForOtp) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the full code')),
      );

      return;
    }

    final result = EmailOTP.verifyOTP(otp: code);
    if (result) {
      if (!mounted) return;
      Navigator.pop(context, true); // return true
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid code. Please try again')),
      );
    }
  }

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
            padding: const EdgeInsets.only(top: 85),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              children: [
                const Text(
                  'Email Verification Sent!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    '''A verification code was sent to\n${widget.userEmail}''',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Form(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(lenForOtp, (index) {
                      return SizedBox(
                        width: 50,
                        height: 50,
                        child: TextFormField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            counterText: '',
                            hintText: '0',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 24,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ),
                          onChanged: (value) => otpChanget(index, value),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 24),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                    children: [
                      const TextSpan(
                        text: "Haven't received the verification code?",
                      ),
                      TextSpan(
                        text: ' Resend it',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            EmailOTP.sendOTP(email: widget.userEmail);
                          },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: _verifyOtp,
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 32),
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
                        'Submit',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
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
                child: Image.asset('assets/log_reg_images/otp.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
