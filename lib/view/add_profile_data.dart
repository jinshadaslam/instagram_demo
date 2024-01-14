import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import '../utils/widgets.dart';
import '../view_modal.dart/asses_gallary.dart';
import '../view_modal.dart/firebase_intraction.dart';
import '../view_modal.dart/theam_provider.dart';
import 'mainpage.dart';

class Add_profile_data extends StatefulWidget {
  const Add_profile_data({super.key});

  @override
  State<Add_profile_data> createState() => _Add_profile_dataState();
}

class _Add_profile_dataState extends State<Add_profile_data> {
  Widgets mywidgets = Widgets();
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  File file = File('/storage/emulated/0/Download/file.png');

  late ui.Image bitimage;
  final controller = CropController(
    aspectRatio: 1,
    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );
  @override
  Widget build(BuildContext context) {
    final gallary = Provider.of<Asses_gallary>(context);
    final theme = Provider.of<Themechange>(context);
    final firebase = Provider.of<FirebaseConnect>(context);
    return Scaffold(
      appBar: AppBar(
        title: mywidgets.mytext('add profile data', context),
        actions: [mywidgets.custom_switch(theme)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              color: gallary.pickedImage == null
                  ? Colors.amber
                  : theme.dark_baground,
              child: gallary.pickedImage == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              gallary.gallary_selecter(context);
                            },
                            icon: Icon(Icons.add_a_photo_outlined),
                            iconSize: 75),
                        Text('add profile photo'),
                      ],
                    )
                  : CropImage(
                      controller: controller,
                      alwaysMove: true,
                      image:
                          Image.file(gallary.pickedImage!, fit: BoxFit.cover),
                    ),
            ),
            SizedBox(height: 20),
            Container(
              height: 60,
              width: 200,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 47, 137, 211),
                  borderRadius: BorderRadius.circular(45)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () => gallary.cancel_photo(),
                      icon: Icon(Icons.close),
                    ),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(
                                      'Do you want to change change photo'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("no"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        image_change(gallary);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("yes"),
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: Icon(Icons.edit)),
                  ]),
            ),
            SizedBox(height: 20),
            mywidgets.textfield(
                theme: theme, textEditer: name, labeltext: 'name'),
            SizedBox(height: 20),
            mywidgets.textfield(
                theme: theme, textEditer: age, labeltext: 'age'),
            SizedBox(height: 30),
            SizedBox(
                height: 60,
                width: 350,
                child: ElevatedButton(
                    onPressed: () async {
                      firebase.loading = true;
                      await saveCroppedImage();
                      await firebase.uploadFile(
                          imagefile: file, age: age.text, name: name.text);
                      firebase.loading = false;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Botomnavigation()),
                      );
                    },
                    child: firebase.loading == false
                        ? Text(
                            'Continue',
                            style: TextStyle(fontSize: 20),
                          )
                        : Center(
                            child: CircularProgressIndicator(
                            color: Colors.white,
                          ))))
          ],
        ),
      ),
    );
  }

  image_change(Asses_gallary gallary) async {
    await gallary.cancel_photo();
    gallary.gallary_selecter(context);
  }

  Future<void> saveCroppedImage() async {
    try {
      // Assuming 'controller' is your image controller
      final bitImage = await controller.croppedBitmap();

      // Convert cropped image to bytes
      final ByteData? data =
          await bitImage.toByteData(format: ImageByteFormat.png);
      if (data == null) {
        print('Error converting image to bytes.');
        return; // Stop further execution if conversion fails
      }
      final bytes = data.buffer.asUint8List();

      // Write bytes to file
      final Directory tempDir = await getTemporaryDirectory();
      file = File('${tempDir.path}/cropped_image.png');
      await file.writeAsBytes(bytes, flush: true);

      print('Image saved successfully at: ${file.path}');
    } catch (e) {
      print('Error saving image: $e');
      // Handle error accordingly
    }
  }
}
