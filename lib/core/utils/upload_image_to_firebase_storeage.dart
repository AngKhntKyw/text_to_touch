import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadImageToFirebaseStorage({
  required Uint8List imageFile,
  required String ref,
  required FirebaseStorage firebaseStorage,
}) async {
  UploadTask uploadTask = firebaseStorage.ref().child(ref).putData(imageFile);
  TaskSnapshot taskSnapshot = await uploadTask;
  String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  return downloadUrl;
}
