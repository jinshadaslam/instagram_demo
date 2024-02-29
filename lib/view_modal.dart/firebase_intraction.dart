import 'dart:io';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:instagram_demo/modal/userdata.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseConnect extends ChangeNotifier {
  Userdata? userdata;
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

      await users
          .doc(email)
          .set({'full_name': name, 'age': age, 'url': downloadURL})
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
      await getUserData();
      loading = false;
      notifyListeners();
    } catch (e) {
      print('Error occurred: $e');
      loading = false;

      notifyListeners();
    }
  }

  Future<void> getUserData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    print('start.............');

    try {
      DocumentSnapshot snapshot =
          await users.doc(_auth.currentUser?.email).get();

      print('${snapshot.data()}');

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        // Check if the document exists before trying to access its data
        userdata = Userdata(
          fullName: data?["full_name"],
          age: data?["age"],
          url: data?["url"],
        );
        print('all done');
      } else {
        print("Document does not exist");
      }
    } catch (e) {
      print("Something went wrong: $e");
      // Handle the error more gracefully, log it, or display an error message
    }
  }
}
