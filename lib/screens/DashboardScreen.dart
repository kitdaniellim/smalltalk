import 'package:flutter/material.dart';
import 'package:smalltalk/screens/MessageScreen.dart';
import 'package:smalltalk/screens/LoginScreen.dart';
import 'package:smalltalk/widgets/ScreenArguments.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Instance of Firestore, use this to retrieve data from the Cloud Firestore

class DashboardScreen extends StatefulWidget {
  static String routeName = "dashboard";

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  TextEditingController _searchController = TextEditingController();
  String uid = FirebaseAuth.instance.currentUser.uid.toString();
  Query otherUsers = FirebaseFirestore.instance.collection("users").where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser.uid.toString());
  @override
  Widget build(BuildContext context) {

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
        otherUsers = FirebaseFirestore.instance.collection("users").where("uid", isNotEqualTo: uid);
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
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Leaving?'),
                  content: const Text('Are you sure you want to log out?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              ),
              child: Icon(Icons.logout, size: 26.0, color: Colors.white),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: otherUsers.snapshots(),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22.0, vertical: 10.0),
                    child: Text(
                      "CONTACTS",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(10.0),
                        itemBuilder: (context, index) {
                          return Container(
                            height: 80.0,
                            width: 60.0,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    MessageScreen.routeName,
                                    arguments: ScreenArguments(
                                      snapshot.data.docs[index]["displayName"],
                                      snapshot.data.docs[index]["uid"],
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 2.0),
                                      child: Icon(
                                        Icons.account_circle,
                                        size: 42.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data.docs[index]["displayName"]
                                          .split(" ")[0],
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              leading: const Icon(
                                Icons.account_circle,
                                size: 50.0,
                                color: Colors.black,
                              ),
                              title: Text(
                                  snapshot.data.docs[index]["displayName"]),
                              // subtitle: Text(
                              //   "long text yeah long text long long and very long aaaaaaaas asfasfasfh kjasfhfk jasd",
                              //   maxLines: 1,
                              //   overflow: TextOverflow.ellipsis,
                              //   style: TextStyle(
                              //     fontSize: 15,
                              //     color: Color(0xFFCAC3C3),
                              //   ),
                              // ),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  MessageScreen.routeName,
                                  arguments: ScreenArguments(
                                    snapshot.data.docs[index]["displayName"],
                                    snapshot.data.docs[index]["uid"],
                                  ),
                                );
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
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22.0, vertical: 10.0),
                    child: Text(
                      "ACTIVE",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22.0, vertical: 18.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: EdgeInsets.all(8),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                      ),
                      controller: _searchController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        _searchController.clear();
                        setState(() {
                          otherUsers = FirebaseFirestore.instance.collection("users").where("uid", isNotEqualTo: uid).where("search", arrayContains: value.toLowerCase());
                        });
                      },
                    ),
                    alignment: Alignment.center,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              leading: const Icon(
                                Icons.account_circle,
                                size: 50.0,
                                color: Colors.black,
                              ),
                              title: Text(
                                  snapshot.data.docs[index]["displayName"]),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  MessageScreen.routeName,
                                  arguments: ScreenArguments(
                                    snapshot.data.docs[index]["displayName"],
                                    snapshot.data.docs[index]["uid"],
                                  ),
                                );
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
