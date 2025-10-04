import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:test_app/core/error/exceptions.dart';
import 'package:test_app/core/utils/upload_image_to_firebase_storeage.dart';
import 'package:test_app/features/product/data/models/product_model.dart';
import 'package:uuid/uuid.dart';

abstract interface class ProductRemoteDatasource {
  Future<List<ProductModel>> getProducts({required String categoryId});
  Future<ProductModel> addNewProduct({
    required String categoryId,
    required ProductModel product,
    required Uint8List image,
  });
  Future<ProductModel> updateProduct({
    required String categoryId,
    required ProductModel product,
    required Uint8List image,
  });
  Future<bool> deleteProduct({
    required String categoryId,
    required String productId,
  });
}

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  final FirebaseFirestore fireStore;
  final FirebaseStorage firebaseStorage;
  final FirebaseAuth firebaseAuth;
  const ProductRemoteDatasourceImpl({
    required this.fireStore,
    required this.firebaseStorage,
    required this.firebaseAuth,
  });

  @override
  Future<List<ProductModel>> getProducts({required String categoryId}) async {
    try {
      final snapshot = await fireStore
          .collection('category')
          .doc(categoryId)
          .collection('product')
          .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(statusCode: 500, message: e.message ?? "$e");
    } catch (e) {
      throw ServerException(statusCode: 500, message: "$e");
    }
  }

  @override
  Future<ProductModel> addNewProduct({
    required String categoryId,
    required ProductModel product,
    required Uint8List image,
  }) async {
    try {
      final id = const Uuid().v1();
      final imageUrl = await uploadImageToFirebaseStorage(
        imageFile: image,
        ref: "productImage/${firebaseAuth.currentUser!.uid}/$id",
        firebaseStorage: firebaseStorage,
      );

      final productRef = fireStore
          .collection('category')
          .doc(categoryId)
          .collection('product')
          .doc();

      final newProduct = product.copyWith(id: productRef.id, image: imageUrl);
      await productRef.set(newProduct.toJson());

      await fireStore
          .collection('product')
          .doc(newProduct.id)
          .set(newProduct.toJson());

      return newProduct;
    } on FirebaseException catch (e) {
      throw ServerException(statusCode: 500, message: e.message ?? "$e");
    } catch (e) {
      throw ServerException(statusCode: 500, message: "$e");
    }
  }

  @override
  Future<ProductModel> updateProduct({
    required String categoryId,
    required ProductModel product,
    required Uint8List image,
  }) async {
    try {
      final id = const Uuid().v1();
      final imageUrl = await uploadImageToFirebaseStorage(
        imageFile: image,
        ref: "productImage/${firebaseAuth.currentUser!.uid}/$id",
        firebaseStorage: firebaseStorage,
      );

      final productRef = fireStore
          .collection('category')
          .doc(categoryId)
          .collection('product')
          .doc(product.id);

      final newProduct = product.copyWith(image: imageUrl);
      await productRef.update(newProduct.toJson());

      await fireStore
          .collection('product')
          .doc(newProduct.id)
          .update(newProduct.toJson());

      return newProduct;
    } on FirebaseException catch (e) {
      throw ServerException(statusCode: 500, message: e.message ?? "$e");
    } catch (e) {
      throw ServerException(statusCode: 500, message: "$e");
    }
  }

  @override
  Future<bool> deleteProduct({
    required String categoryId,
    required String productId,
  }) async {
    try {
      final productRef = fireStore
          .collection('category')
          .doc(categoryId)
          .collection('product')
          .doc(productId);

      final snapshot = await productRef.get();
      if (!snapshot.exists) {
        throw ServerException(statusCode: 404, message: "Product not found");
      }
      await productRef.delete();

      final DocumentReference docRef = fireStore
          .collection('product')
          .doc(productId);
      await docRef.delete();

      return true;
    } on FirebaseException catch (e) {
      log(e.toString());
      throw ServerException(statusCode: 500, message: e.message ?? "$e");
    } catch (e) {
      log(e.toString());
      throw ServerException(statusCode: 500, message: "$e");
    }
  }
}
