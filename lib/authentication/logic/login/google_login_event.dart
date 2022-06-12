part of 'google_login_bloc.dart';

abstract class GoogleLoginEvent extends Equatable {
  const GoogleLoginEvent();
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends GoogleLoginEvent {
 final BuildContext context;
  const LoginButtonPressed({
    required this.context,
  });

  @override
  List<Object> get props => [context];
}
