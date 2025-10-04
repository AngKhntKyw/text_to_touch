import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:test_app/init_dependencies.dart';

void initFirebase() {
  final fireAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final fireMessage = FirebaseMessaging.instance;
  final firebaseStorage = FirebaseStorage.instance;

  serviceLocator.registerLazySingleton(() => fireAuth);
  serviceLocator.registerLazySingleton(() => fireStore);
  serviceLocator.registerLazySingleton(() => fireMessage);
  serviceLocator.registerLazySingleton(() => firebaseStorage);
}
