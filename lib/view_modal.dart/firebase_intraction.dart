import 'dart:io';

import 'package:path/path.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseConnect extends ChangeNotifier {
  bool loading = false;
  String downloadURL = '';

  Future<void> uploadFile(
      {required File imagefile,
      required String name,
      required String age}) async {
    final fileName = basename(imagefile.path);
    final destination = 'files/$fileName';
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
      loading = false;
      notifyListeners();
    } catch (e) {
      print('Error occurred: $e');
      loading = false;
      notifyListeners();
    }
  }
}
