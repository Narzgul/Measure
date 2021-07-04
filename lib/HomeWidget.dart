import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

Widget buildHome(BuildContext context, String title) {
  return Scaffold(
    appBar: AppBar(
      title: Text(title),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Angle of you phone:',
            style: Theme
                .of(context)
                .textTheme
                .headline5,
          ),
          Text(
            "X: ${degValues[0]}°",
            style: Theme
                .of(context)
                .textTheme
                .headline4,
            textAlign: TextAlign.center,
          ),
          Text(
            "Y: ${degValues[1]}°",
            style: Theme
                .of(context)
                .textTheme
                .headline4,
            textAlign: TextAlign.center,
          ), Text(
            "Z: ${degValues[2]}°",
            style: Theme
                .of(context)
                .textTheme
                .headline4,
            textAlign: TextAlign.center,
          ),

        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      tooltip: 'Reset',
      onPressed: () {
        radValues = [0.0, 0.0, 0.0];
      },
      child: Icon(Icons.exposure_zero),
    ), // This trailing comma makes auto-formatting nicer for build methods.
  );
}