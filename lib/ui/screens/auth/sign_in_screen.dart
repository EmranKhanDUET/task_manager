import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/auth/sign_up_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';

import 'email_verification_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passTEController = TextEditingController();

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
                    'Get Started With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: 'E-Mail'),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passTEController,
                    decoration: const InputDecoration(hintText: 'Password'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _onTapNextButton,
                    child: const Icon(Icons.arrow_circle_right_outlined),
                  ),
                  const SizedBox(height: 36),
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                            onPressed: _onTapForgotPasswordButton,
                            child: const Text('Forgot Password?')),
                        RichText(
                          text: TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(.8),
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: .4),
                              children: [
                                TextSpan(
                                    text: 'Sign up',
                                    style: const TextStyle(
                                      color: AppColors.themeColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = _onTapSignUpButton)
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  void _onTapForgotPasswordButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmailVerificationScreen(),
      ),
    );
  }


  void _onTapSignUpButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }  void _onTapNextButton() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainBottomNavScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passTEController.dispose();
    super.dispose();
  }
}
