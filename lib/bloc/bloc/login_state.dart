part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginInprocess extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginModal logindata;
  LoginSuccess({required this.logindata});
  @override
  List<Object> get props => [logindata];
}

class LoginError extends LoginState {}
