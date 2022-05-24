import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kist/Services/Apiconnectservices.dart';
import 'package:kist/main.dart';
import 'package:kist/modal/authuser.dart';

part 'authuserdata_state.dart';

class AuthuserdataCubit extends Cubit<AuthuserdataState> {
  AuthuserdataCubit() : super(AuthuserdataInitial());

  authuserCall() async {
    print("authapi call");
    emit(Authuserdatafetching());
    try {
      final response = await getIt<ApiConnectService>().authUserdata();
      if (response?.error == null) {
        emit(AuthuserdataFetched(authdata: response!));
      } else {
        emit(AuthuserdataError());
      }
    } catch (e) {
      emit(AuthuserdataError());
    }
  }
}
