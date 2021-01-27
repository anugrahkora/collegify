import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:collegify/shared/components/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class OpenImage extends StatefulWidget {
  final String imageUrl;
  final String imageName;
  final String imagePath;
  final DocumentSnapshot documentSnapshot;
  final String path;

  const OpenImage(
      {Key key,
      this.imageUrl,
      this.imageName,
      this.documentSnapshot,
      this.path, this.imagePath})
      : super(key: key);

  @override
  _OpenImageState createState() => _OpenImageState();
}

class _OpenImageState extends State<OpenImage> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: HexColor(appPrimaryColour),
        title: HeadingText(
          alignment: Alignment.topLeft,
          text: widget.imageName,
          color: Colors.black54,
        ),
        actions: [
          IconButton(
              icon: _loading
                  ? Loader(
                      size: 20.0,
                      color: HexColor(appPrimaryColour),
                      spinnerColor: Colors.black54,
                    )
                  : Icon(
                      Icons.download_rounded,
                      color: Colors.black54,
                    ),
              onPressed: () async {
                setState(() {
                  _loading = true;
                });
                await _downloadImage();
                setState(() {
                  _loading = false;
                });
              })
        ],
      ),
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: PinchZoom(
            image: Image.network(widget.imageUrl),
            zoomedBackgroundColor: Colors.black.withOpacity(0.5),
            resetDuration: const Duration(milliseconds: 100),
            maxScale: 2.5,
          ),
        ),
      ),
    );
  }

  Future<void> _downloadImage() async {
    Directory appDocDir = await getExternalStorageDirectory();

    File downloadToFile = File('${appDocDir.path}/${widget.imageName}.jpg');
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(widget.path)
          .child(widget.imagePath)
          .writeToFile(downloadToFile);
    } on firebase_core.FirebaseException catch (e) {
      print(e.message);
      print(appDocDir.path);
    }
  }
}
