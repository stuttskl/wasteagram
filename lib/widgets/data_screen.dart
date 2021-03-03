import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataScreen extends StatefulWidget {
@override

  _DataScreenState createState() => _DataScreenState();
}


class _DataScreenState extends State<DataScreen> {
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('example').snapshots(),
      builder: (context, record) {
        if (record.hasData) {
          return ListView.builder(
            itemCount: record.data.documents.length,
            itemBuilder: (context, index) {
              var post = record.data.document[index];
              return ListTile(
                leading: Text(post['name']),
                title: Text('post title?')
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}