import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_app/core/error/exceptions.dart';
import 'package:test_app/features/category/data/models/category_model.dart';
import 'package:uuid/uuid.dart';

abstract interface class CategoryRemoteDatasource {
  Future<List<CategoryModel>> getCategories();
  Future<CategoryModel> addNewCategory({required String name});
  Future<CategoryModel> updateCategory({required CategoryModel category});
  Future<bool> deleteCategory({required String categoryId});
}

class CategoryRemoteDatasourceImpl implements CategoryRemoteDatasource {
  final FirebaseFirestore fireStore;
  const CategoryRemoteDatasourceImpl({required this.fireStore});

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final snapshot = await fireStore.collection('category').get();
      return snapshot.docs
          .map((doc) => CategoryModel.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(statusCode: 500, message: e.message ?? "$e");
    } catch (e) {
      throw ServerException(statusCode: 500, message: "$e");
    }
  }

  @override
  Future<CategoryModel> addNewCategory({required String name}) async {
    try {
      final String categoryId = const Uuid().v4();
      final category = CategoryModel(id: categoryId, name: name);
      await fireStore
          .collection('category')
          .doc(categoryId)
          .set(category.toJson());

      return category;
    } on FirebaseException catch (e) {
      throw ServerException(statusCode: 500, message: e.message ?? "$e");
    } catch (e) {
      throw ServerException(statusCode: 500, message: "$e");
    }
  }

  @override
  Future<CategoryModel> updateCategory({
    required CategoryModel category,
  }) async {
    try {
      final DocumentReference docRef = fireStore
          .collection('category')
          .doc(category.id);

      await docRef.update(category.toJson());

      return category;
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        throw ServerException(
          statusCode: 404,
          message: "Category with ID ${category.id} not found.",
        );
      }
      throw ServerException(statusCode: 500, message: e.message ?? "$e");
    } catch (e) {
      throw ServerException(statusCode: 500, message: "$e");
    }
  }

  @override
  Future<bool> deleteCategory({required String categoryId}) async {
    try {
      final DocumentReference docRef = fireStore
          .collection('category')
          .doc(categoryId);

      await docRef.delete();
      return true;
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        throw ServerException(
          statusCode: 404,
          message: "Category with ID $categoryId not found.",
        );
      }
      throw ServerException(statusCode: 500, message: e.message ?? "$e");
    } catch (e) {
      throw ServerException(statusCode: 500, message: "$e");
    }
  }
}
