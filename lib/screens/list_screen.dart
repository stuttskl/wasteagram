
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../models/post.dart';


class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  Stream<QuerySnapshot> posts =
      FirebaseFirestore.instance.collection('posts').snapshots();

  
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
