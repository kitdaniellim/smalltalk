import 'package:flutter/material.dart';
import './screens/LoginScreen.dart';
import './routes.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      canvasColor: Color(0xFFC2E1F2),
      primaryColor: Colors.white,
      // accentColor: Colors.yellow[800],
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 18.0),
      ),
    ),
    routes: routes,
    home: LoginScreen(),
  ));
}
