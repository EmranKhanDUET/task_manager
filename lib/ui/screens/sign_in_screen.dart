import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BackgroundWidget(child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 80),
                Text('Get Started With'),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Name'
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                SizedBox(height: 8),
                ElevatedButton(onPressed: (){}, child: Icon(Icons.arrow_circle_right_outlined)),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
