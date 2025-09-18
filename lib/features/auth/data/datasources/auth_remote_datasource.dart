import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:test_app/core/common/constants/constants.dart';
import 'package:test_app/core/error/exceptions.dart';
import 'package:test_app/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserCredential?> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserCredential?> logInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<void> logOut();
}

//

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth fireAuth;
  final FirebaseFirestore fireStore;
  final FirebaseMessaging fireMessage;
  const AuthRemoteDataSourceImpl({
    required this.fireAuth,
    required this.fireStore,
    required this.fireMessage,
  });

  @override
  Future<UserCredential?> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential user = await fireAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await user.user!.updateDisplayName(name);
      String? fcmToken = await fireMessage.getToken(
        vapidKey:
            "BIuZvfJ8AFDkp73N0f2H0D728YQtYAr9M-SwJ022fvUCXt3bE2KNhTcQ3kmZOy20n3y3Oth_8CKPRgJJTZWuh7I",
      );
      await user.user!.updatePhotoURL(Constant.defaultAvater);

      final userModel = UserModel(
        user_id: fireAuth.currentUser!.uid,
        name: name,
        email: email,
        fcm_token: fcmToken!,
        is_online: true,
        last_online: DateTime.now(),
        in_chat: true,
        profile_url: Constant.defaultAvater,
        cover_url: Constant.defaultAvater,
      );

      await fireStore
          .collection("users")
          .doc(fireAuth.currentUser!.uid)
          .set(userModel.toJson());

      return user;
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message!, statusCode: 404);
    } catch (e) {
      log(e.toString());
      throw ServerException(message: "$e", statusCode: 404);
    }
  }

  @override
  Future<UserCredential?> logInWithEmailPassword({
    required String email,

    required String password,
  }) async {
    try {
      UserCredential user = await fireAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message!, statusCode: 404);
    } catch (e) {
      throw ServerException(message: "$e", statusCode: 404);
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await fireAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw ServerException(message: e.message!, statusCode: 404);
    } catch (e) {
      throw ServerException(message: "$e", statusCode: 404);
    }
  }
}
