import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/post.dart';

class ListScreenEntry extends StatelessWidget {
  final post;
  final date;

  ListScreenEntry({Key key, this.post, this.date});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
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
      )
    );
  }
}