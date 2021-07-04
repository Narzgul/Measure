import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:measure/HomeWidget.dart';
import 'package:sensors_plus/sensors_plus.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

var radValues = [0.0, 0.0, 0.0];
var degValues = [0, 0, 0];
var gyroValues = [0.0, 0.0, 0.0];
class _HomePageState extends State<HomePage> {

  Timer? radUpdate;

  @override
  Widget build(BuildContext context) {
    return buildHome(context, widget.title);
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

  FloatingActionButton resetRad() {
    return FloatingActionButton(
      tooltip: 'Reset',
      onPressed: () {
        radValues = [0.0, 0.0, 0.0];
      },
      child: Icon(Icons.exposure_zero),
    );
  }
}