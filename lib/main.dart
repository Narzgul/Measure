import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measure',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Measure Angle'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var radValues = [0.0, 0.0, 0.0];
  var degValues = [0, 0, 0];
  var gyroValues = [0.0, 0.0, 0.0];
  Timer? radUpdate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Angle of you phone:',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              "X: ${degValues[0]}°",
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            Text(
              "Y: ${degValues[1]}°",
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),Text(
              "Z: ${degValues[2]}°",
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Reset',
        onPressed: () { radValues = [0.0, 0.0, 0.0]; },
        child: Icon(Icons.exposure_zero),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    super.initState();

    gyroscopeEvents.listen((GyroscopeEvent event) {
      gyroValues[0] = event.x;
    });
    gyroscopeEvents.listen((GyroscopeEvent event) {
      gyroValues[1] = event.y;
    });
    gyroscopeEvents.listen((GyroscopeEvent event) {
      gyroValues[2] = event.z;
    });
    radUpdate = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        for(var i = 0; i < 3; i++) {
          radValues[i] = radValues[i] + gyroValues[i] / 10;
          degValues[i] = (radValues[i] * (180 / pi)).round();
        }
      });
    });
  }

  @override
  void dispose() {
    radUpdate?.cancel();
    super.dispose();
  }
}
