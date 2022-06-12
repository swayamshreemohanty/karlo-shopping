part of 'google_login_bloc.dart';

@immutable
abstract class GoogleLoginState {}

class GoogleLoginInitial extends GoogleLoginState {}
class GoogleLoginLoading extends GoogleLoginState {}

