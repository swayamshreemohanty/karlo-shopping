import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/authentication/logic/login/google_login_bloc.dart';
import 'package:shopping_app/utility/loading_indicator.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({
    Key? key,
  }) : super(key: key);

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleLoginBloc, GoogleLoginState>(
      builder: (context, state) {
        if (state is GoogleLoginLoading) {
          return const LoadingIndicator();
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              onPressed: () async {
                context
                    .read<GoogleLoginBloc>()
                    .add(LoginButtonPressed(context: context));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Image(
                      image: AssetImage("assets/google_logo.png"),
                      height: 28,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Continue with Google',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
