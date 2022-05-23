import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kist/Services/Apiconnectservices.dart';
import 'package:kist/Services/storageservice.dart';
import 'package:kist/main.dart';
import 'package:kist/modal/logniresponsemodal.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<Logininitial>((event, emit) {
      // TODO: implement event handler
    });
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginInprocess());
      print(event.email);
      try {
        final response = await getIt<ApiConnectService>().callloginapi(event);
        if (response?.error == null) {
          Storage().setloginstatus(true, response?.token);
          emit(LoginSuccess(logindata: response!));
        }
      } catch (e) {
        emit(LoginError());
      }
      // TODO: implement event handler
    });
  }
}
