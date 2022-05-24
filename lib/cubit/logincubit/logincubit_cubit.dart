import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kist/Services/Apiconnectservices.dart';
import 'package:kist/Services/storageservice.dart';
import 'package:kist/bloc/loginbloc/login_bloc.dart';
import 'package:kist/main.dart';
import 'package:kist/modal/logniresponsemodal.dart';

part 'logincubit_state.dart';

class LogincubitCubit extends Cubit<LogincubitState> {
  LogincubitCubit() : super(LogincubitInitial());
  loginapicall(email, password) async {
    print(email);
    emit(LogincubitButtonpressed());
    try {
      final response =
          await getIt<ApiConnectService>().callloginapicubit(email, password);
      if (response?.error == null) {
        Storage().setloginstatus(true, response?.token);
        emit(LogincubitSuccess(loginmodal: response!));
      }
    } catch (e) {
      emit(LogincubitError());
    }
  }
}
