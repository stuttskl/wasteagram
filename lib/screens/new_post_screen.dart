import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:transparent_image/transparent_image.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'; // storing files in bucket and get url back
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/screens/new_post_screen.dart';

class NewPostScreen extends StatefulWidget {
  static const routeName = 'newPostScreen';

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getImage();
  }

  Future<String> getImage() async {
    File image;
    final picker = ImagePicker();

    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    image = File(pickedFile.path);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });

    Reference storageReference = FirebaseStorage.instance.ref().child(DateTime
            .now()
        .toIso8601String()); // saving the image file name as a date time string to ensure uniqueness

    UploadTask uploadTask = storageReference.putFile(image);

    final url = await (await uploadTask).ref.getDownloadURL();

    print(url); // stick this in the posts collection as imgUrl

    FirebaseFirestore.instance.collection('posts').add({
      'imgUrl': url,
      'numWasted': 22,
      'timeStamp': DateTime.now().toIso8601String()
    });

    print("added!");
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('wasteagram - # of wasted items')),
        body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ],
            )),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.all(0.0),
            child: GestureDetector(
              onTap: () {
                print("upload pressed");
              },
              child: Container(
                alignment: Alignment.bottomCenter,
                width: 500,
                height: 150,
                color: Colors.blue,
                child:
                    Icon(Icons.cloud_upload, size: 150.0, color: Colors.white),
              ),
            )));
  }
}
