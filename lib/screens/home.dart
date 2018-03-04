import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_charts/flutter_charts.dart';

final googleSignIn = new GoogleSignIn();

class FinLogStartPage extends StatefulWidget {
  FinLogStartPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<FinLogStartPage> {
  int _counter = 0;
  ChartData _chartData;
  LineChartOptions _lineChartOptions;

  Future<String> _getData() async {
    var response = await http.get(
        Uri.encodeFull('https://jsonplaceholder.typicode.com/posts'),
        headers: {"Accept": "application/json"});
    List data = JSON.decode(response.body);
    print(data[1]["title"]);
  }

  Future<Null> _ensureLoggedIn() async {
    GoogleSignInAccount user = googleSignIn.currentUser;
    if (user == null) user = await googleSignIn.signInSilently();
    if (user == null) await googleSignIn.signIn();
    print("sign in " + googleSignIn.currentUser.displayName);
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void defineOptionsAndData() {
    _chartData = new ChartData();
    _chartData.dataRowsLegends = [
      "Spring",
      "Summer",
    ];
    _chartData.dataRows = [
      [
        10.0,
        20.0,
        5.0,
        30.0,
        5.0,
        20.0,
      ],
      [
        10.0,
        20.0,
        5.0,
        30.0,
        5.0,
        30.0,
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    defineOptionsAndData();
    LineChart lineChart = new LineChart(
      painter: new LineChartPainter(),
      size: Size.infinite,
      layouter: new LineChartLayouter(
          chartData: _chartData, chartOptions: _lineChartOptions),
    );

    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Expanded(
              child: new Card(
                child: new Text(
                  'You have spent (Rs):',
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ),
            new Expanded(
              child: new Card(
                child: new Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ),
            new Row(
              children: <Widget>[
                new IconButton(
                  icon: new Icon(
                    Icons.chat,
                    color: Colors.blue,
                  ),
                  // Execute when pressed
                  onPressed: () {
                    // use the navigator to goto a named route
                    Navigator.of(context).pushNamed('/about');
                  },
                  // Setting the size of icon
                  iconSize: 80.0,
                ),
                new IconButton(
                  icon: new Icon(
                    Icons.assessment,
                    color: Colors.red,
                  ),
                  // Execute when pressed
                  onPressed: () {
                    // use the navigator to goto a named route
                    Navigator.of(context).pushNamed('/summary');
                  },
                  iconSize: 80.0,
                ),
                new IconButton(
                  icon: new Icon(
                    Icons.code,
                    color: Colors.green,
                  ),
                  onPressed: _getData,
                  iconSize: 80.0,
                ),
                new IconButton(
                  icon: new Icon(
                    Icons.account_circle,
                    color: Colors.green,
                  ),
                  onPressed: _ensureLoggedIn,
                  iconSize: 80.0,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
