import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kist/Services/storageservice.dart';

part 'checklogin_event.dart';
part 'checklogin_state.dart';

class CheckloginBloc extends Bloc<CheckloginEvent, CheckloginState> {
  CheckloginBloc() : super(CheckloginInitial()) {
    on<LoginStatusCheck>((event, emit) async {
      emit(CheckloginChecking());
      var loginstatus = await Storage().getLoginstatus();
      if (loginstatus == true) {
        emit(CheckloginStatusTrue());
      } else {
        emit(CheckloginStatusFalse());
      }
    });
  }
}
