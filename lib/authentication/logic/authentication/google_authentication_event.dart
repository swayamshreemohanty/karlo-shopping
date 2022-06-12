part of 'google_authentication_bloc.dart';

@immutable
abstract class GoogleAuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppStarted extends GoogleAuthenticationEvent {}

class LoggedIn extends GoogleAuthenticationEvent {}

class LoggedOut extends GoogleAuthenticationEvent {
  final BuildContext context;
  LoggedOut({
    required this.context,
  });
  @override
  List<Object?> get props => [context];
}
