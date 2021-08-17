import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'dart:io';

class Messaging {
  Future<void> uploadImageToFirebase(String filePath) async {
    File file = File(filePath);
    try {
      await FirebaseStorage.instance
          .ref('uploads/$filePath')
          .putFile(file);
    } on FirebaseException catch (e) {
    }
  }
}