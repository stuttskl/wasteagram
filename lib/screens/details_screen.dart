import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:intl/intl.dart';

import '../models/post.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = 'detailsScreen';
  @override
  Widget build(BuildContext context) {
    final Post args = ModalRoute.of(context).settings.arguments;
    print("in details_screen, args.imgUrl is: ");
    print(args.imgUrl);

    return Scaffold(
        appBar: AppBar(title: Text('wasteagram')),
        body: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat('yMMMMEEEEd')
                  .format(DateTime.parse(args.timeStamp.toString())),
              style: Theme.of(context).textTheme.headline4,
            ),
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: args.imgUrl,
            ),
            Text('Number of Wasted Items: ' + args.numWasted.toString(),
                style: Theme.of(context).textTheme.headline5),
            Text(
                'Lat, Long: ' +
                    args.lat.toString() +
                    ', ' +
                    args.long.toString(),
                style: Theme.of(context).textTheme.bodyText2)
          ],
        )));
  }
}
