part of 'checklogin_bloc.dart';

abstract class CheckloginState extends Equatable {
  const CheckloginState();

  @override
  List<Object> get props => [];
}

class CheckloginInitial extends CheckloginState {}

class CheckloginChecking extends CheckloginState {}

class CheckloginStatusTrue extends CheckloginState {}

class CheckloginStatusFalse extends CheckloginState {}
