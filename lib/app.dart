import 'package:flutter/material.dart';

import './screens/list_screen.dart';
import './screens/details_screen.dart';
import './screens/new_post_screen.dart';


class App extends StatelessWidget {
  var routes = {
    DetailsScreen.routeName: (context) => DetailsScreen(),
    NewPostScreen.routeName: (context) => NewPostScreen()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      title: 'wasteagram',
      theme: ThemeData.dark(),
      home: ListScreen()
    );
  }
}



