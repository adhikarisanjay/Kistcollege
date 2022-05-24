part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryFetching extends CategoryState {}

class Categoryfetched extends CategoryState {
  final List<Category> categorydata;
  Categoryfetched({required this.categorydata});
  @override
  List<Object> get props => [categorydata];
}

class CategoryNull extends CategoryState {}

class CategoryError extends CategoryState {}
