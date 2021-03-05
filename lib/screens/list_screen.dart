import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'; // storing files in bucket and get url back
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/screens/new_post_screen.dart';

import '../models/post.dart';
import '../models/posts.dart';

class ListScreen extends StatefulWidget {
  final String url;

  ListScreen({this.url});
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  // Stream<QuerySnapshot> posts =
  //     FirebaseFirestore.instance.collection('posts').snapshots();

  // Future<String> getImage() async {
  //   File image;
  //   final picker = ImagePicker();
  //   print("inside of get image top");
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   image = File(pickedFile.path);

  //   setState(() {
  //     if (pickedFile != null) {
  //       image = File(pickedFile.path);
  //     } else {
  //       print('No image selected');
  //     }
  //   });
  //   print("after set state");

  //   Reference storageReference = FirebaseStorage.instance.ref().child(DateTime
  //           .now()
  //       .toIso8601String()); // saving the image file name as a date time string to ensure uniqueness

  //   UploadTask uploadTask = storageReference.putFile(image);

  //   final url = await (await uploadTask).ref.getDownloadURL();

  //   print(url); // stick this in the posts collection as imgUrl
  //   return url;

  //   // FirebaseFirestore.instance.collection('posts').add({
  //   //   'imgUrl': url,
  //   //   'numWasted': 22,
  //   //   'timeStamp': DateTime.now().toIso8601String()
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('wasteagram - # of wasted items')),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context, record) {
            if (record.hasData &&
                record.data.docs != null &&
                record.data.docs.length > 0) {
              return ListView.builder(
                itemCount: record.data.docs.length,
                itemBuilder: (context, index) {
                  var post = record.data.docs[index];
                  return ListTile(
                      leading: Text(DateFormat('yMMMMEEEEd').format(
                          DateTime.parse(post['timeStamp'].toString()))),
                      trailing: Text(post['numWasted'].toString()),
                      onTap: () => {
                            Navigator.pushNamed(context, 'detailsScreen',
                                arguments: Post(
                                    // id: post['id'],
                                    imgUrl: post.data()['imgUrl'],
                                    lat: post.data()['lat'],
                                    long: post.data()['long'],
                                    numWasted: post.data()['numWasted'],
                                    timeStamp: post.data()['timeStamp']))
                          }
                      // onTap: () => goToDetailsScreen(context, 'detailsScreen',
                      // index - 1) // might be an issuew tih this
                      );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.pushNamed(context, 'newPostScreen',)
        },
        tooltip: 'Add New Image',
        child: Icon(Icons.add_a_photo),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
