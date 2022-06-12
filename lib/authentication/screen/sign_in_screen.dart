import 'package:flutter/material.dart';
import 'package:shopping_app/authentication/widget/google_sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(83, 139, 104, 1),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/splash_screen_logo.png',
                height: 300,
              ),
              SizedBox(height: deviceSize.height * 0.1),
              const GoogleSignInButton()
            ],
          ),
        ),
      ),
    );
  }
}
