import 'package:smalltalk/screens/SettingsScreen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  static String routeName = "dashboard";

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SettingsScreen.routeName);
              },
              child: Icon(Icons.settings, size: 26.0),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text("Dashboard"),
      ),
    );
  }
}
