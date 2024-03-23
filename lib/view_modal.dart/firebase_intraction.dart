import 'dart:io';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:instagram_demo/modal/profiledata.dart';
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

    String? email = _auth.currentUser?.email;
    try {
      loading = true;
      notifyListeners();

      // Get the directory for saving the file
      String downloadURL = await saveimage(imagefile: imagefile);
      // Set the content type to 'image/jpeg' explicitly

      await users
          .doc(email)
          .set({'full_name': name, 'age': age, 'url': downloadURL})
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
      String userid = _auth.currentUser!.uid;
      final DBRef = FirebaseDatabase.instance.ref().child('profiles/$userid');
      await DBRef.update({
        'username': email,
        "full_name": name,
        "bio": "A brief description about the user",
        "followers": 0,
        "following": 0,
        "posts": 0
      });
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

  Future<void> writeData(
      {required String discription, required File imagefile}) async {
    final imageId = DateTime.now().millisecondsSinceEpoch.toString();
    String userid = _auth.currentUser!.uid;
    final DBRef = FirebaseDatabase.instance
        .ref()
        .child('profiles/$userid/images/$imageId');

    String url = await saveimage(imagefile: imagefile);

    try {
      print('started writing');
      loading = true;
      notifyListeners();
      await DBRef.update(
          {'url': url, 'discription': discription, 'likes': 0, 'comment': {}});
      print('done writing');
      loading = false;
      notifyListeners();
    } catch (e) {
      print("Something went wrong: $e");
      loading = false;
      notifyListeners();
    }
  }

  Future<String> saveimage({required File imagefile}) async {
    final destination = _auth.currentUser?.email;
    final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
    final metadata =
        firebase_storage.SettableMetadata(contentType: 'image/jpeg');
    try {
      await ref.putFile(
        imagefile,
        metadata,
      );
      downloadURL = await ref.getDownloadURL();
      print('ldfijnjnfvvjnfdkjvn     fkjnvdfkjnv  kjdnfknkxnf$downloadURL');

      return downloadURL;
    } catch (e) {
      print('image save faild $e');
      return '';
    }
  }

  Stream<DatabaseEvent> getMessageStream() {
    final databaseReference = FirebaseDatabase.instance.ref();
    String userid = _auth.currentUser!.uid;
    return databaseReference.child('profiles/$userid').onValue;
  }
}
