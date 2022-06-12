import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/authentication/logic/authentication/google_authentication_bloc.dart';
import 'package:shopping_app/authentication/repository/google_auth_repository.dart';
part 'google_login_event.dart';
part 'google_login_state.dart';

class GoogleLoginBloc extends Bloc<GoogleLoginEvent, GoogleLoginState> {
  final GoogleAuthenticationBloc googleAuthenticationBloc;
  final GoogleAuthenticationRepository googleAuthenticationRepository;
  GoogleLoginBloc({
    required this.googleAuthenticationBloc,
    required this.googleAuthenticationRepository,
  }) : super(GoogleLoginInitial()) {
    on<GoogleLoginEvent>(
      (event, emit) async {
        if (event is LoginButtonPressed) {
          try {
            emit(GoogleLoginLoading());
            await googleAuthenticationRepository
                .signInWithGoogle(context: event.context)
                .whenComplete(
              () {
                {
                  emit(GoogleLoginInitial());
                  googleAuthenticationBloc.add(LoggedIn());
                }
              },
            );
          } catch (e) {
            emit(GoogleLoginInitial());
          }
        }
      },
    );
  }
}
