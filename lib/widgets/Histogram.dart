import 'package:flutter_charts/flutter_charts.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Histogram extends StatefulWidget {
  Histogram({Key key, this.title}) : super(key: key);
  static const String routeName = "/summary";
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<Histogram> {
  LineChartOptions _lineChartOptions;
  ChartOptions _verticalBarChartOptions;

  ChartData _chartData;

  _MyHomePageState() {
    defineOptionsAndData();
  }

  void defineOptionsAndData() {
    _lineChartOptions = new LineChartOptions();
    _verticalBarChartOptions = new VerticalBarChartOptions();
    _chartData = new ChartData();
    _chartData.dataRowsLegends = ["Spring", "Summer", "Fall", "Winter"];
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
      [
        25.0,
        40.0,
        20.0,
        80.0,
        12.0,
        90.0,
      ],
      [
        25.0,
        40.0,
        20.0,
        80.0,
        12.0,
        100.0,
      ],
    ];
    _chartData.xLabels = ["Wolf", "Deer", "Owl", "Mouse", "Hawk", "Vole"];
    _chartData.assignDataRowsDefaultColors();
    // Note: ChartOptions.useUserProvidedYLabels default is still used (false);
  }

  void _chartStateChanger() {
    setState(() {});
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

    VerticalBarChart verticalBarChart = new VerticalBarChart(
      painter: new VerticalBarChartPainter(),
      size: Size.infinite,
      layouter: new VerticalBarChartLayouter(
          chartData: _chartData, chartOptions: _verticalBarChartOptions),
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Container(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Expanded(
              flex: 2,
              child: lineChart, //
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _chartStateChanger,
        tooltip: 'New Random Data',
        child: new Icon(Icons.add),
      ),
    );
  }
}
