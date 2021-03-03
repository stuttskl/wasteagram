import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import './screens/list_screen.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Wasteagram'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File image;
  final picker = ImagePicker();
  Future getImage() async {
    print("inside of get image");
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    image = File(pickedFile.path);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('example.jpg'); // Path.basename(image.path) as alt
    UploadTask uploadTask = storageReference.putFile(image);
    print(uploadTask);

    final url = await (await uploadTask).ref.getDownloadURL();

    print(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListScreen(),
      // body: Center(
      //     child: Column(children: [
      //   Center(
      //       child:
      //           image == null ? Text('no image selected') : Image.file(image)),
      //   StreamBuilder(
      //       stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      //       builder: (context, record) {
      //         if (record.hasData &&
      //             record.data.docs != null &&
      //             record.data.docs.length > 0) {
      //           return ListView.builder(
      //             itemCount: record.data.docs.length,
      //             itemBuilder: (context, index) {
      //               var post = record.data.docs[index];
      //               return ListTile(
      //                   leading: Text(post['imgUrl']),
      //                   title: Text(post['numWasted'].toString()));
      //             },
      //           );
      //         } else {
      //           return Center(child: CircularProgressIndicator());
      //         }
      //       })
      // ])),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
