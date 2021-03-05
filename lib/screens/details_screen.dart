import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:io';
import 'package:intl/intl.dart';


import '../models/post.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = 'detailsScreen';
  @override
  Widget build(BuildContext context) {
    final Post args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(title: Text('wasteagram')),
        body: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(DateFormat('yMMMMEEEEd').format(DateTime.parse(args.timeStamp.toString())), style: Theme.of(context).textTheme.headline5,),
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: args.imgUrl,
            ),
            Text('Number of Wasted Items: ' + args.numWasted.toString(), style: Theme.of(context).textTheme.headline3),
            Text('Lat, Long: ' + args.lat.toString() + ', ' + args.long.toString(), style: Theme.of(context).textTheme.bodyText2)
          ],
        )));
  }
}
