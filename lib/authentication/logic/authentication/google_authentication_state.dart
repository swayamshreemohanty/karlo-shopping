part of 'google_authentication_bloc.dart';

@immutable
abstract class GoogleAuthenticationState {}

class AuthenticationUninitialized extends GoogleAuthenticationState {}

class AuthenticationAuthenticated extends GoogleAuthenticationState {}

class AuthenticationUnauthenticated extends GoogleAuthenticationState {}

class AuthenticationLoading extends GoogleAuthenticationState {}
