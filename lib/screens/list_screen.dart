import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/post.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
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
        builder: (context, record) {
          if (record.hasData && record.data.docs != null && record.data.docs.length > 0) {
            return ListView.builder(
              itemCount: record.data.docs.length,
              itemBuilder: (context, index) {
                var post = record.data.docs[index];
                var date = record.data.docs[index]['timeStamp'].toDate().toString();
                return ListTile(
                  leading: Text(DateFormat('yMMMMEEEEd').format(post['timeStamp'].toDate()).toString()),
                  onTap: () => {
                    Navigator.pushNamed(context, 'detailsScreen', arguments: 
                      Post(
                        imgUrl: post.get('imgUrl'),
                        quantity: post.get('quantity'),
                        lat: post.get('lat'),
                        long: post.get('long'),
                        timeStamp: date
                      )
                    )
                  },
                  trailing: Text(post['quantity'].toString(), style: Theme.of(context).textTheme.headline5),
                );
              },
            );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
      ),
      floatingActionButton: Semantics(
        child: 
          FloatingActionButton(
            onPressed: () => {
              Navigator.pushNamed(context, 'newPostScreen')
            },
            tooltip: 'Add New Image',
            child: Icon(Icons.add_a_photo),
          ),
        label: 'Add New Post',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
