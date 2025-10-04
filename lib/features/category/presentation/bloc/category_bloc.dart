import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/core/usecase/usecase.dart';
import 'package:test_app/features/category/data/models/category_model.dart';
import 'package:test_app/features/category/domain/usecases/add_new_category.dart';
import 'package:test_app/features/category/domain/usecases/delete_category.dart';
import 'package:test_app/features/category/domain/usecases/get_categories.dart';
import 'package:test_app/features/category/domain/usecases/update_category.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategories _getCategories;
  final AddNewCategory _addNewCategory;
  final UpdateCategory _updateCategory;
  final DeleteCategory _deleteCategory;

  List<CategoryModel> _categories = [];

  CategoryBloc({
    required GetCategories getCategories,
    required AddNewCategory addNewCategory,
    required UpdateCategory updateCategory,
    required DeleteCategory deleteCategory,
  }) : _getCategories = getCategories,
       _addNewCategory = addNewCategory,
       _updateCategory = updateCategory,
       _deleteCategory = deleteCategory,
       super(CategoryInitial()) {
    on<CategoryEvent>((_, emit) => emit(CategoryLoading()));
    on<GetCategoriesEvent>(onGetCategoriesEvent);
    on<AddNewCategoryEvent>(onAddNewCategoryEvent);
    on<UpdateCategoryEvent>(onUpdateCategoryEvent);
    on<DeleteCategoryEvent>(onDeleteCategoryEvent);
  }

  void onGetCategoriesEvent(
    GetCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    final response = await _getCategories.call(NoParams());
    response.fold((failure) => emit(CategoryFailure(failure: failure)), (
      categories,
    ) {
      _categories = categories;
      emit(CategoryLoaded(categories: _categories));
    });
  }

  void onAddNewCategoryEvent(
    AddNewCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());

    final response = await _addNewCategory.call(
      AddNewCategoryParams(name: event.name),
    );

    response.fold((failure) => emit(CategoryFailure(failure: failure)), (
      category,
    ) {
      _categories = [..._categories, category];
      emit(CategoryAdded(category: category, categories: _categories));
    });
  }

  void onUpdateCategoryEvent(
    UpdateCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    final response = await _updateCategory.call(
      UpdateCategoryParams(category: event.categoryModel),
    );

    response.fold((failure) => emit(CategoryFailure(failure: failure)), (
      category,
    ) {
      _categories = _categories
          .map((c) => c.id == category.id ? category : c)
          .toList();
      emit(CategoryUpdated(category: category, categories: _categories));
    });
  }

  void onDeleteCategoryEvent(
    DeleteCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    final response = await _deleteCategory.call(
      DeleteCategoryParams(categoryId: event.categoryId),
    );

    response.fold((failure) => emit(CategoryFailure(failure: failure)), (
      category,
    ) {
      _categories.removeWhere((c) => c.id == event.categoryId);
      emit(CategoryDeleted(categories: _categories));
    });
  }
}
