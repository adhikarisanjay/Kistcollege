part of 'checklogin_bloc.dart';

abstract class CheckloginEvent extends Equatable {
  const CheckloginEvent();

  @override
  List<Object> get props => [];
}

class LoginStatusCheck extends CheckloginEvent {}
