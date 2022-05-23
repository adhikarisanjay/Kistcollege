part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class Logininitial extends LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String? email;
  final String? password;

  LoginButtonPressed({this.email, this.password});
}
