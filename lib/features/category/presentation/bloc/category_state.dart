part of 'category_bloc.dart';

@immutable
sealed class CategoryState {
  const CategoryState();
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;
  const CategoryLoaded({required this.categories});
}

final class CategoryAdded extends CategoryState {
  final CategoryModel category;
  final List<CategoryModel> categories;
  const CategoryAdded({required this.category, required this.categories});
}

final class CategoryUpdated extends CategoryState {
  final CategoryModel category;
  final List<CategoryModel> categories;
  const CategoryUpdated({required this.category, required this.categories});
}

final class CategoryDeleted extends CategoryState {
  final List<CategoryModel> categories;
  const CategoryDeleted({required this.categories});
}

final class CategoryFailure extends CategoryState {
  final Failure failure;
  const CategoryFailure({required this.failure});
}
