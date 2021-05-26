import 'package:smalltalk/screens/MessageScreen.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

//Instance of Firestore, use this to retrieve data from the Cloud Firestore

class DashboardScreen extends StatefulWidget {
  static String routeName = "dashboard";

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("users");

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

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
                Navigator.pushNamed(context, MessageScreen.routeName);
              },
              child: Icon(Icons.add, size: 26.0, color: Colors.white),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: users.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(
                "This isn't supposed to be here. :( something went wrong in retrieving the data");
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            );
          } else {
            if (_selectedIndex == 0) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
                    child: Text(
                      "CONTACTS",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8DA5B1),
                      ),
                    ),
                    
                    alignment: Alignment.topLeft,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(15.0),
                        itemBuilder: (context, index) {
                          return Container(
                            width: 60.0,
                            child: GestureDetector(
                              onTap: () {
                                print('Opened ' +
                                    snapshot.data.docs[index]["displayName"] +
                                    "'s chat message");
                                Navigator.pushNamed(
                                    context, MessageScreen.routeName);
                              },
                              child: Icon(
                                Icons.account_circle,
                                size: 50.0,
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
                        itemCount: snapshot.data.docs.length,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: 150.0,
                      color: Color(0xFFE6F0F6),
                      child: ListView.builder(
                        padding: EdgeInsets.all(15.0),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              leading: const Icon(
                                Icons.account_circle,
                                size: 50.0,
                                color: Colors.black,
                              ),
                              title: Text(snapshot.data.docs[index]["displayName"]),
                              subtitle: Text(
                                "long text yeah long text long long and very long aaaaaaaas asfasfasfh kjasfhfk jasd",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFFCAC3C3),
                                ),
                              ),
                              onTap: () {
                                print('Opened ' +
                                    snapshot.data.docs[index]["displayName"] +
                                    "'s chat message");
                                Navigator.pushNamed(
                                    context, MessageScreen.routeName);
                              },
                            ),
                          );
                        },
                        itemCount: snapshot.data.docs.length,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              print(_selectedIndex);
              return Container();
            }
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Friends',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFFFFFFF),
        onTap: _onItemTapped,
      ),
    );
  }
}
