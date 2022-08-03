import 'dart:async';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class FaceRecogn extends StatefulWidget {
  const FaceRecogn({Key key}) : super(key: key);

  @override
  State<FaceRecogn> createState() => _FaceRecognState();
}

class _FaceRecognState extends State<FaceRecogn> {
  File _image;
  Future getImagefromcamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;

    // final imageTemporary = File(image.path);
    setState(() {
      _image = File(image.path);
    });
  }

  Future getImagefromGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _image = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Facial Recognition"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Select an image",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              child: Center(
                child: _image == null
                    ? Text("No Image is picked")
                    : Image.file(_image),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                onPressed: getImagefromcamera,
                tooltip: "Pick Image form gallery",
                child: Icon(Icons.add_a_photo),
              ),
              FloatingActionButton(
                onPressed: getImagefromGallery,
                tooltip: "Pick Image from camera",
                child: Icon(Icons.camera_alt),
              )
            ],
          )
        ],
      ),
    );
  }
}
