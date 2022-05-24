import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kist/Services/Apiconnectservices.dart';
import 'package:kist/main.dart';
import 'package:kist/modal/categorymodal.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  fetchcategorydata() async {
    print("authapi call");
    emit(CategoryFetching());
    try {
      final response = await getIt<ApiConnectService>().categoriesApi();
      if (response != null) {
        emit(Categoryfetched(categorydata: response));
      } else {
        emit(CategoryNull());
      }
    } catch (e) {
      emit(CategoryError());
    }
  }
}
