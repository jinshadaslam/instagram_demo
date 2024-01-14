import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class Asses_gallary extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  File? pickedImage; // Store the picked image file

  String downloadURL = '';
  Future<void> getImageFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      print('image path    ${pickedImage?.path}');
      notifyListeners();
    }
  }

  Future<void> getImageFromCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      print(pickedImage?.path);
      notifyListeners();
    }
  }

  cancel_photo() {
    pickedImage = null;
    notifyListeners();
  }

  Future<dynamic> gallary_selecter(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select an Image"),
          content: Text("Choose an image from your gallery or take a photo"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                getImageFromGallery();
                notifyListeners();
              },
              child: Text("Gallery"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                getImageFromCamera();
                notifyListeners();
              },
              child: Text("Camera"),
            ),
          ],
        );
      },
    );
  }
}
