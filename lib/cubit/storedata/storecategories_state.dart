part of 'storecategories_cubit.dart';

abstract class StorecategoriesState extends Equatable {
  const StorecategoriesState();

  @override
  List<Object> get props => [];
}

class StorecategoriesInitial extends StorecategoriesState {}

class StorecategoriesButtonPressed extends StorecategoriesState {}

class StorecategoriesStored extends StorecategoriesState {}

class StorecategoriesError extends StorecategoriesState {}
