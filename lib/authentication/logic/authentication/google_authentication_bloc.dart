import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_app/authentication/repository/google_auth_repository.dart';
part 'google_authentication_event.dart';
part 'google_authentication_state.dart';

class GoogleAuthenticationBloc
    extends Bloc<GoogleAuthenticationEvent, GoogleAuthenticationState> {
  GoogleAuthenticationRepository googleAuthenticationRepository;
  GoogleAuthenticationBloc({required this.googleAuthenticationRepository})
      : super(AuthenticationUnauthenticated()) {
    on<GoogleAuthenticationEvent>((event, emit) async {
      if (event is AppStarted) {
        emit(AuthenticationLoading());
        final getCurrentUser = await GoogleSignIn().signInSilently();
        if (getCurrentUser == null) {
          emit(AuthenticationUnauthenticated());
        } else {
          emit(AuthenticationAuthenticated());
        }
      } else if (event is LoggedIn) {
        emit(AuthenticationAuthenticated());
      } else if (event is LoggedOut) {
        emit(AuthenticationLoading());
        await googleAuthenticationRepository
            .signOut(context: event.context)
            .whenComplete(
              () => emit(AuthenticationUnauthenticated()),
            );
      }
    });
  }
}
