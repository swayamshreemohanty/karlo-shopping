import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              Image.asset(
                'assets/splash_screen_logo.png',
                height: 100.h,
              ),
              SizedBox(height: 40.h),
              Text(
                "Karlo Shopping",
                style: GoogleFonts.abhayaLibre(
                  textStyle: TextStyle(fontSize: 40.sp),
                ),
              ),
              const Spacer(),
              const GoogleSignInButton(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
