import 'package:flutter/material.dart';
import 'package:wasteagram/app.dart';

import '../models/post.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  void goToDetailsScreen(context, id) {
    print("inside of go to details screen for id: " + id.toString());
    Navigator.pushNamed(context, 'detailsScreen', arguments:
      Post(
        imgUrl: "https://www.theflavorbender.com/wp-content/uploads/2014/09/Simpsons-Doughnuts-4238-Copy-1.jpg",
        lat: 0,
        long: 0,
        numWasted: 0,
        timeStamp: "test"
      )
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('hi')),
    body: ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Wednesday, March 3rd 2021'), // date of post
          trailing: Text(1.toString()), // number of items wasted
          onTap:  () => goToDetailsScreen(context, index -1) // might have to -1 from this idk yet
        );
      },
    )
    );
    // add photo FAB here
  }
}