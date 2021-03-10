import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              DateFormat('yMMMMEEEEd').format(DateTime.parse(args.timeStamp.toString())),
              style: Theme.of(context).textTheme.headline4,
            ),
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: args.imgUrl,
            ),
            Text(args.quantity.toString() + ' items',
              style: Theme.of(context).textTheme.headline5
            ),
            Text(
              'Location: (' + args.lat.toString() + ', ' + args.long.toString() + ')',
              style: Theme.of(context).textTheme.bodyText2
            ),
          ]
        )
      )
    );
  }
}