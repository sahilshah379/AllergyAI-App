import 'package:allergy_ai_app/profile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'dart:io';

class Messaging {
  final DatabaseReference _reference = FirebaseDatabase.instance.reference().child('user');
  Future<void> uploadImageToFirebase(String filePath) async {
    File file = File(filePath);
    try {
      await FirebaseStorage.instance
          .ref('uploads/$filePath')
          .putFile(file);
    } on FirebaseException catch (e) {
    }
  }
  void sendDataToFirebase() {
    var allergies = ['a1','a2','a3'];
    var delim = String.fromCharCode(0x1B);
    var al = allergies.join(delim);
    print(al);
    _reference.push().set(toJson(al));
  }
  Map<dynamic, dynamic> toJson(String allergies) => <dynamic, dynamic>{
    'id': 'google id',
    'name': 'Sahil Shah',
    'allergies': allergies,
  };
}