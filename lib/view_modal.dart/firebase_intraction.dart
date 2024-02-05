import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseConnect extends ChangeNotifier {
  bool loading = false;
  String downloadURL = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> uploadFile(
      {required File imagefile,
      required String name,
      required String age}) async {
    final fileName = basename(imagefile.path);
    final destination = '$name';
    String? email = _auth.currentUser?.email;
    try {
      loading = true;
      notifyListeners();

      // Get the directory for saving the file
      final ref = firebase_storage.FirebaseStorage.instance.ref(destination);

      // Set the content type to 'image/jpeg' explicitly
      final metadata =
          firebase_storage.SettableMetadata(contentType: 'image/jpeg');

      await ref.putFile(
        imagefile,
        metadata,
      );
      downloadURL = await ref.getDownloadURL();
      print('ldfijnjnfvvjnfdkjvn     fkjnvdfkjnv  kjdnfknkxnf$downloadURL');

      users
          .doc(email)
          .set({'full_name': name, 'age': age, 'url': downloadURL})
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
      loading = false;
      notifyListeners();
    } catch (e) {
      print('Error occurred: $e');
      loading = false;
      notifyListeners();
    }
  }
}
