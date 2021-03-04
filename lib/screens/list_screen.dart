import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../models/post.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
//   Future<List<Post>> getAllPosts() async {
//     Stream<QuerySnapshot> qShot = FirebaseFirestore.instance.collection('posts').snapshots();

//     return qShot.map( (doc) => 
//       Post(
//         imgUrl: doc.data['imgUrl'],
//         lat: doc.data['lat'],
//         long: doc.data['long'],
//         timeStamp: doc.data['timeStamp'],
//         numWasted: doc.data['numWasted']
//       )
//     ).toList();
//   }

  // Stream<QuerySnapshot> posts =
  //     FirebaseFirestore.instance.collection('posts').snapshots();
  void goToDetailsScreen(context, id) {
    // print("inside of go to details screen for id: " + id.toString());
    Navigator.pushNamed(context, 'detailsScreen',
        arguments: Post(
            imgUrl: "imgUrl test",
            lat: 0,
            long: 0,
            numWasted: 0,
            timeStamp: "test"));
  }

  void addPhoto() {
    print("add photo pressed!");
    FirebaseFirestore.instance.collection('posts').add({
      'imgUrl': 'Img URL from addPhoto',
      'numWasted': 10
    });
  }

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
                    leading: Text(post['imgUrl']),
                    title: Text(post['numWasted'].toString()),
                    onTap: () => goToDetailsScreen(context, index - 1)
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addPhoto(),
        tooltip: 'Add New Image',
        child: Icon(Icons.add_a_photo),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
