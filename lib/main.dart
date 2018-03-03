import 'package:flutter/material.dart';
import 'package:finlog/screens/chat.dart';
import 'package:finlog/screens/home.dart';

void main() => runApp(new FinLog());

class FinLog extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Finance Log',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new FinLogStartPage(title: 'Udhari Spending Log'),
      routes: <String, WidgetBuilder>{
        // Set named routes
        FriendlychatApp.routeName: (BuildContext context) =>
            new FriendlychatApp(),
      },
    );
  }
}

