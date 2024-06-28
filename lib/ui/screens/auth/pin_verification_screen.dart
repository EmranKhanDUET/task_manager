import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screens/auth/reset_password_screen.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  Text(
                    'Pin Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  // const SizedBox(height: 24),
                  Text(
                    'A 6 digits verification has been sent to your email address',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 24),
                  _buildPinCodeTextField(),

                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed:_onTapVerifyButton,
                    child: const Text('Verify'),
                  ),
                  const SizedBox(height: 36),
                  _buildSignInSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center _buildSignInSection() {
    return Center(
      child: RichText(
        text: TextSpan(
            text: "Have  account? ",
            style: TextStyle(
                color: Colors.black.withOpacity(.8),
                fontWeight: FontWeight.w400,
                letterSpacing: .4),
            children: [
              TextSpan(
                  text: 'Sign In',
                  style: const TextStyle(
                    color: AppColors.themeColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = _onTapSignInButton)
            ]),
      ),
    );
  }

  Widget _buildPinCodeTextField() {
    return PinCodeTextField(
      length: 6,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.white,
          selectedFillColor: Colors.white,
          inactiveFillColor: Colors.white,
          selectedColor: AppColors.themeColor),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      keyboardType: TextInputType.number,
      controller: _pinTEController,
      appContext: context,
    );
  }

  void _onTapSignInButton() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
        (route) => false);
  }

  void _onTapVerifyButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ResetPasswordScreen(),
      ),
    );
  }

  @override
  void dispose() {
    if (_pinTEController == null) {
      _pinTEController.dispose();
    }

    super.dispose();
  }
}
