import 'package:flutter/material.dart';

class NewMessageScreen extends StatefulWidget {
  static String routeName = "settings";

  @override
  NewMessageScreenState createState() => NewMessageScreenState();
}

class NewMessageScreenState extends State<NewMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Color(0xFFC2E1F2),
        title: Text('New Message',
            style: TextStyle(
                letterSpacing: 1.0,
                color: Colors.white,
                fontFamily: 'Quicksand',
                fontSize: 17.0,
                fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Text("New Message Screen"),
        ),
      ),
    );
  }
}
