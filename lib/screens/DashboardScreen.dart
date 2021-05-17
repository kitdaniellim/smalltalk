import 'package:smalltalk/screens/NewMessageScreen.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

//Instance of Firestore, use this to retrieve data from the Cloud Firestore

class DashboardScreen extends StatefulWidget {
  static String routeName = "dashboard";

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("users");

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
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("This isn't supposed to be here. :( something went wrong");
            }
            if (!snapshot.hasData) {
              return Text("Loading your messages...");
            } else {
              return Column(
                  children: snapshot.data.docs
                      .map((doc) => new ListTile(title: new Text(doc["name"])))
                      .toList());
            }
          },
        ));
  }
}
