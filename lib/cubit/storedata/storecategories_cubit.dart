import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kist/Services/Apiconnectservices.dart';
import 'package:kist/main.dart';

part 'storecategories_state.dart';

class StorecategoriesCubit extends Cubit<StorecategoriesState> {
  StorecategoriesCubit() : super(StorecategoriesInitial());
  storedata(title, desc, image) async {
    emit(StorecategoriesButtonPressed());
    try {
      final response = await getIt<ApiConnectService>()
          .categoriesstoreApi(title, desc, image);
      if (response?.error == null) {
        emit(StorecategoriesStored());
      } else {
        emit(StorecategoriesError());
      }
    } catch (e) {
      emit(StorecategoriesError());
    }
  }
}
