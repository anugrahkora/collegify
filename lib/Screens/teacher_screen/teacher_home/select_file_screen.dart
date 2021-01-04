import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SelectFileScreen extends StatefulWidget {
  final DocumentSnapshot docs;
  final String className;
  final String semester;

  const SelectFileScreen({Key key, this.docs, this.className, this.semester})
      : super(key: key);
  @override
  _SelectFileScreenState createState() => _SelectFileScreenState();
}

class _SelectFileScreenState extends State<SelectFileScreen> {
  File _imageFile;
  final picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final PickedFile pickedFile = await picker.getImage(source: source);

    _imageFile = File(pickedFile.path);
  }

  /// Remove image
  void _clear() 
  {
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
        actions: [
          if (_imageFile != null)
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
                onPressed: _clear)
        ],
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

      // Preview the image
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 35.0),
            if (_imageFile != null) ...[
              Container(
                child: Center(
                  child: Image.file(
                    _imageFile,
                    width: size.width * 0.8,
                    height: size.width * 0.8,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              SizedBox(
                height: 80.0,
              ),
              Uploader(
                file: _imageFile,
                docs: widget.docs,
                className: widget.className,
                semester: widget.semester,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class Uploader extends StatefulWidget {
  final String className;
  final String semester;
  final File file;
  final DocumentSnapshot docs;

  Uploader({Key key, this.file, this.docs, this.className, this.semester})
      : super(key: key);

  createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  UploadTask _uploadTask;
  String _message = 'Done';
  String _notes = 'Notes';

  _startUpload() {
    String _filePath =
        '${widget.docs.data()['University']}/${widget.docs.data()['College']}/$_notes/${widget.docs.data()['Department']}/${widget.docs.data()['Course']}/${widget.semester}/${widget.docs.data()['University']}/${widget.className}/${DateTime.now()}';
    if (widget.file != null) {
      try {
        final _storage = FirebaseStorage.instance.ref().child(_filePath);

        setState(() {
          _uploadTask = _storage.putFile(widget.file);
        });
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<TaskSnapshot>(
          stream: _uploadTask.snapshotEvents,
          builder: (context, snapshot) {
            var event = snapshot?.data;

            double progressPercent =
                event != null ? event.bytesTransferred / event.totalBytes : 0;

            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_uploadTask.snapshot.state == TaskState.paused)
                    FlatButton(
                      child: Icon(Icons.play_arrow, size: 50),
                      onPressed: _uploadTask.resume,
                    ),
                  if (_uploadTask.snapshot.state == TaskState.running) ...[
                    FlatButton(
                      child: Icon(Icons.pause, size: 50),
                      onPressed: _uploadTask.pause,
                    ),
                    LinearProgressIndicator(
                      value: progressPercent,
                      backgroundColor: HexColor(appSecondaryColour),
                      semanticsValue: '${(progressPercent * 100)} % ',
                    ),
                  ],
                  if (_uploadTask.snapshot.state == TaskState.success) ...[
                    SizedBox(
                      height: 4.0,
                    ),
                    AlertWidget(
                      icon: Icons.done,
                      message: _message,
                      color: Colors.green,
                      onpressed: () {
                        setState(() {
                          _message = null;
                          _uploadTask = null;
                        });
                      },
                    ),
                  ],

                 
                ]);
          });
    } else {
      return RoundedButton(
        text: 'Upload',
        color: HexColor(appSecondaryColour),
        onPressed: _startUpload,
        loading: false,
      );
    }
  }
}
