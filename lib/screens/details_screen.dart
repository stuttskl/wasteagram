import 'package:flutter/material.dart';
import 'dart:io';

import '../models/post.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = 'detailsScreen';
  @override
  Widget build(BuildContext context) {
    final Post args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(title: Text(args.timeStamp)),
        body: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.file(image),
            Text(args.imgUrl),
            Text(args.timeStamp),
            Text(args.numWasted.toString()),
            Text(args.lat.toString() + ', ' + args.long.toString())
          ],
        )));
  }
}
