part of 'logincubit_cubit.dart';

abstract class LogincubitState extends Equatable {
  const LogincubitState();

  @override
  List<Object> get props => [];
}

class LogincubitInitial extends LogincubitState {}

class LogincubitButtonpressed extends LogincubitState {}

class LogincubitSuccess extends LogincubitState {
  final LoginModal loginmodal;
  LogincubitSuccess({required this.loginmodal});
}

class LogincubitError extends LogincubitState {}
