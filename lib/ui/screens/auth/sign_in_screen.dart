import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/auth/sign_up_screen.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';
import '../../utility/app_constants.dart';
import 'email_verification_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _signInApiInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Text(
                      'Get Started With',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(hintText: 'E-Mail'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your email';
                        }
                        if (AppConstants.emailRegEx.hasMatch(value!) == false) {
                          return 'Enter a valid email';
                        }
                        {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      obscureText: !_showPassword,
                      controller: _passTEController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              _onTapShowPasswordIcon();
                            },
                            icon: Icon(_showPassword
                                ? Icons.visibility
                                : Icons.visibility_off)),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Enter the password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Visibility(
                      visible: _signInApiInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: _onTapNextButton,
                        child: const Icon(Icons.arrow_circle_right_outlined),
                      ),
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
      ),
    );
  }

  Future<void> signIn() async {
    _signInApiInProgress = true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> requestData = {
      "email": _emailTEController.text.trim(),
      "password": _passTEController.text
    };

    NetworkResponse response =
        await NetworkCaller.postRequest(Urls.login, body: requestData);
    _signInApiInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (mounted) {
      if (response.isSuccess) {
        LoginModel loginModel = LoginModel.fromJson(response.responseData);

        await AuthController.saveUserAccessToken(loginModel.token!);
        await AuthController.saveUserData(loginModel.userModel!);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MainBottomNavScreen()));
      } else {
        snackBarMessage(
            context,
            response.errorMessage ??
                'Email or Password error. Please try again',
            true);
      }
    }
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
  }

  void _onTapNextButton() {
    if (_formKey.currentState!.validate()) {
      signIn();
    }
  }

  void _onTapShowPasswordIcon() {
    _showPassword = !_showPassword;
    setState(() {});
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passTEController.dispose();
    super.dispose();
  }
}
