import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'; // storing files in bucket and get url back
import 'package:transparent_image/transparent_image.dart';
import 'package:wasteagram/widgets/upload_button.dart';

import '../db/new_post_dto.dart';
import '../widgets/new_post_form.dart';
import '../widgets/upload_button.dart';

class NewPostScreen extends StatefulWidget {
  static const routeName = 'newPostScreen';

  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final newPostValues = NewPostDTO();

  LocationData locationData;
  var locationService = Location();

  @override
  void initState() {
    super.initState();
    getImage();
    retrieveLocation();
  }

  void addDateToNewPostValues() {
    newPostValues.timeStamp = DateTime.now();
  }

  void retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
    newPostValues.lat = locationData.latitude;
    newPostValues.long = locationData.longitude;
  }

  Future<String> getImage() async {
    File image;
    String imageUrl;
    final picker = ImagePicker();

    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    image = File(pickedFile.path);

    Reference storageReference = FirebaseStorage.instance.ref().child(DateTime
            .now()
        .toIso8601String()); // saving the image file name as a date time string to ensure uniqueness

    UploadTask uploadTask = storageReference.putFile(image);

    final url = await (await uploadTask).ref.getDownloadURL();
    newPostValues.imgUrl = url;
    imageUrl = url;

    setState(() {
      if (pickedFile != null) {
        imageUrl = pickedFile.path;
      } else {
        print('No image selected');
      }
    });
  }

  void saveEntry(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      addDateToNewPostValues();

      FirebaseFirestore.instance.collection('posts').add({
        'imgUrl': newPostValues.imgUrl,
        'lat': newPostValues.lat,
        'long': newPostValues.long,
        'quantity': newPostValues.quantity,
        'timeStamp': newPostValues.timeStamp,
      });

      Navigator.of(context).pop();
    } else {
      print("invalid, not saving");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('wasteagram - # of wasted items')),
      // body: NewPostForm(),
      body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              newPostValues.imgUrl == null
                  ? CircularProgressIndicator()
                  : FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: newPostValues.imgUrl,
                    ),
              TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Number of Wasted Items',
                    hintStyle: Theme.of(context).textTheme.headline5,
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    final isDigitsOnly = int.tryParse(value);
                    return isDigitsOnly == null
                        ? 'Please enter a quantity'
                        : null;
                  },
                  onSaved: (value) {
                    newPostValues.quantity = int.tryParse(value);
                  }),
            ],
          )),
      // bottomNavigationBar: UploadButton(saveEntry: saveEntry),
      bottomNavigationBar: Semantics(
          label: 'Upload New Post',
          child: Padding(
              padding: EdgeInsets.all(0.0),
              child: GestureDetector(
                onTap: () {
                  // saveEntry(context);
                },
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: 500,
                  height: 150,
                  color: Colors.blue,
                  child: Icon(Icons.cloud_upload,
                      size: 150.0, color: Colors.white),
                ),
              )))
    );
  }
}
