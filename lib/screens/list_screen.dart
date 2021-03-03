import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  void goToDetailsScreen(context, id) {
    print("inside of go to details screen for id: " + id.toString());
    // Navigator.pushNamed(context, 'detailsScreen', arguments:)
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Wednesday, March 3rd 2021'), // date of post
          trailing: Text(1.toString()), // number of items wasted
          onTap:  () => goToDetailsScreen(context, index) // might have to -1 from this idk yet
        );
      },
    );
    // add photo FAB here
  }
}