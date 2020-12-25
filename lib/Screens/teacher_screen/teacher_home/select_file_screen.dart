import 'dart:io';

import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:hexcolor/hexcolor.dart';
//import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SelectFileScreen extends StatefulWidget {
  @override
  _SelectFileScreenState createState() => _SelectFileScreenState();
}

class _SelectFileScreenState extends State<SelectFileScreen> {
  File _imageFile;
  final picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final PickedFile pickedFile = await picker.getImage(source: source);

    // setState(() {
    _imageFile = File(pickedFile.path);
    // });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(appPrimaryColour),
        title: HeadingText(
          alignment: Alignment.topLeft,
          text: "Upload Image",
          color: Colors.black,
        ),
      ),

      backgroundColor: HexColor(appPrimaryColour),

      bottomNavigationBar: BottomAppBar(
        color: HexColor(appPrimaryColour),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.photo_camera,
              ),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            SizedBox(
              width: 40.0,
            ),
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),

      // Preview the image and crop it
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 35.0),
            if (_imageFile != null) ...[
              Container(
                child: Image.file(
                  _imageFile,
                  width: size.width * 0.8,
                  height: size.width * 0.8,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed:()=>uploadImage(),
                    child: Icon(Icons.upload_file),
                  ),
                  FlatButton(
                    child: Icon(Icons.refresh),
                    onPressed: _clear,
                  ),
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
            ],
          ],
        ),
      ),
    );
  }

    Future<void >uploadImage() async {
    final _storage = FirebaseStorage.instance;
    if (_imageFile != null) {
      var snapshot = await _storage
          .ref()
          .child('test')
          .child('/images')
          .putFile(_imageFile)
          .whenComplete(() {
        print('////////////////');
        print('uplaoded');
        print('////////////////');
      });
      print(snapshot.state);

      //var downloadUrl = await snapshot

      // setState(() {
      //   imageUrl = downloadUrl;
      // });

    }
    // todo
  }
}
