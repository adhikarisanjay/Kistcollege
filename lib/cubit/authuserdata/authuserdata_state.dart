part of 'authuserdata_cubit.dart';

abstract class AuthuserdataState extends Equatable {
  const AuthuserdataState();

  @override
  List<Object> get props => [];
}

class AuthuserdataInitial extends AuthuserdataState {}

class Authuserdatafetching extends AuthuserdataState {}

class AuthuserdataFetched extends AuthuserdataState {
  final AuthUser authdata;
  AuthuserdataFetched({required this.authdata});
}

class AuthuserdataError extends AuthuserdataState {}
