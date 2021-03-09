import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wasteagram/widgets/list_screen_entry.dart';

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
                return ListScreenEntry(post: post, date: date);
              });
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
