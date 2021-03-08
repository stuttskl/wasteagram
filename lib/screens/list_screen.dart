import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart'; // storing files in bucket and get url back
import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/screens/new_post_screen.dart';

import '../models/post.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  // Stream<QuerySnapshot> posts =
  //     FirebaseFirestore.instance.collection('posts').snapshots();

  Stream<QuerySnapshot> posts = FirebaseFirestore.instance
      .collection('posts')
      .orderBy('timeStamp', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('wasteagram - # of wasted items')),
      body: StreamBuilder(
          stream: posts,
          // stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context, record) {
            if (record.hasData &&
                record.data.docs != null &&
                record.data.docs.length > 0) {
              // DateTime d =
              //     record.data.docs['timeStamp'].toDate(); // string rep of date
              // print(d);
              return ListView.builder(
                itemCount: record.data.docs.length,
                itemBuilder: (context, index) {
                  var post = record.data.docs[index];
                  var date =
                      record.data.docs[index]['timeStamp'].toDate().toString();
                  print(date);
                  return ListTile(
                      leading: Text(DateFormat('yMMMMEEEEd')
                          .format(post['timeStamp'].toDate())
                          .toString()),
                      subtitle: Text(post['numWasted'].toString()),
                      onTap: () => {
                            Navigator.pushNamed(context, 'detailsScreen',
                                arguments: Post(
                                    imgUrl: post.get('imgUrl'),
                                    numWasted: post.get('numWasted'),
                                    lat: post.get('lat'),
                                    long: post.get('long'),
                                    timeStamp: date))
                          },
                      // trailing: Text(post['numWasted'].toString()),
                      trailing: ElevatedButton(
                        child: Icon(Icons.delete),
                        onPressed: () async => {
                          print("inside of delete?"),
                          await FirebaseFirestore.instance.runTransaction(
                              (Transaction myTransaction) async {
                            myTransaction
                                .delete(record.data.docs[index].reference);
                          })
                        },
                        // onTap: () => goToDetailsScreen(context, 'detailsScreen',index - 1) // might be an issuew tih this
                      ));
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.pushNamed(
            context,
            'newPostScreen',
          )
        },
        tooltip: 'Add New Image',
        child: Icon(Icons.add_a_photo),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
