part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

final class GetCategoriesEvent extends CategoryEvent {}

final class AddNewCategoryEvent extends CategoryEvent {
  final String name;
  AddNewCategoryEvent({required this.name});
}

final class UpdateCategoryEvent extends CategoryEvent {
  final CategoryModel categoryModel;
  UpdateCategoryEvent({required this.categoryModel});
}

final class DeleteCategoryEvent extends CategoryEvent {
  final String categoryId;
  DeleteCategoryEvent({required this.categoryId});
}
