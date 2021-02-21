import 'package:smalltalk/screens/NewMessageScreen.dart';
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
        backgroundColor: Color(0xFFC2E1F2),
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: IconButton(
                icon: const Icon(
                  Icons.account_circle,
                  size: 30.0,
                  color: Colors.white, 
                ),
                onPressed: () {
                  print('ngekngok profile button');
                },
              ),
            );
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, NewMessageScreen.routeName);
              },
              child: Icon(Icons.add, size: 26.0, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text("Dashboard, put chat stuff herehrehrehrhere xoxo"),
      ),
    );
  }
}
