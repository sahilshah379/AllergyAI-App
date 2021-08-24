import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'dart:io';

class Messaging {
  final _reference = FirebaseDatabase.instance.reference();
  Future<void> uploadFileToFirebase(File file, String fileName) async {
    try {
      await FirebaseStorage.instance
          .ref('uploads/' + fileName)
          .putFile(file);
    } on FirebaseException catch (e) { }
  }
  void sendDataToFirebase(String id, String name, String email, String photoURL, List<String> allergies) async {
    await _reference.child(id).set({
      'id': id,
      'name': name,
      'email': email,
      'photoURL': photoURL,
      'allergies': allergies.join(String.fromCharCode(0x1B)),
    });
  }
  Future<DataSnapshot> getDataFromFirebase(String id) async {
    return await _reference.child(id).once();
  }
}