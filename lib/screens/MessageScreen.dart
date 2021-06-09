import 'package:flutter/material.dart';
import 'package:smalltalk/widgets/ScreenArguments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageScreen extends StatefulWidget {
  static String routeName = "settings";

  @override
  MessageScreenState createState() => MessageScreenState();
}

class ChatMessage {
  String content;
  Timestamp createdAt;
  String receiver;
  String sender;
  ChatMessage(
      {required this.content,
      required this.createdAt,
      required this.receiver,
      required this.sender});
}

class MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference dbRef = firestore.collection("messages");

    String selfUUID = FirebaseAuth.instance.currentUser.uid.toString();
    // print(args.uuid);
    // print(selfUUID);
    // Stream<QuerySnapshot> q1 = dbRef
    // .where("receiver", isEqualTo: args.uuid)
    // .where("sender", isEqualTo: selfUUID)
    // .snapshots();

    // q1.forEach((field) {
    //   field.docs.asMap().forEach((index, data) {
    //     messages.add(
    //       ChatMessage(
    //         content: field.docs[index]["content"],
    //         createdAt: field.docs[index]["created_at"],
    //         receiver: field.docs[index]["receiver"],
    //         sender: field.docs[index]["sender"],
    //       ),
    //     );
    //   });
    // });

    // Stream<QuerySnapshot> q2 = dbRef
    //     .where("receiver", isEqualTo: selfUUID)
    //     .where("sender", isEqualTo: args.uuid)
    //     .snapshots();
    // q2.forEach((field) {
    //   field.docs.asMap().forEach((index, data) {
    //     messages.add(
    //       ChatMessage(
    //         content: field.docs[index]["content"],
    //         createdAt: field.docs[index]["created_at"],
    //         receiver: field.docs[index]["receiver"],
    //         sender: field.docs[index]["sender"],
    //       ),
    //     );
    //   });
    // });

    // print(messages.length);
    // messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    //for each item in chat variable, populate the messages list

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: Color(0xFFC2E1F2),
          title: Text(args.name,
              style: TextStyle(
                  letterSpacing: 1.0,
                  color: Colors.white,
                  fontFamily: 'Quicksand',
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600)),
          centerTitle: true,
        ),
        body: StreamBuilder(
            stream: dbRef.snapshots(),
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
                List<ChatMessage> messages = [];
                List<DocumentSnapshot> items = [];
                items = snapshot.data.docs;
                items.forEach((field) {
                  if (field["receiver"] == args.uuid &&
                          field["sender"] == selfUUID ||
                      field["sender"] == args.uuid &&
                          field["receiver"] == selfUUID) {
                    messages.add(
                      ChatMessage(
                        content: field["content"],
                        createdAt: field["created_at"],
                        receiver: field["receiver"],
                        sender: field["sender"],
                      ),
                    );
                  }
                });
                messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
                return Stack(
                  children: <Widget>[
                    ListView.builder(
                      itemCount: messages.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.only(
                              left: 14, right: 14, top: 10, bottom: 10),
                          child: Align(
                            alignment: (messages[index].receiver == selfUUID
                                ? Alignment.topLeft
                                : Alignment.topRight),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (messages[index].receiver == selfUUID
                                    ? Colors.grey.shade200
                                    : Colors.blue[200]),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Text(
                                messages[index].content,
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                        height: 60,
                        width: double.infinity,
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: "Write message...",
                                    hintStyle: TextStyle(color: Colors.black54),
                                    border: InputBorder.none),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                //code to add textfield value to db
                                print('EY MADAFAKA DIS TEXT SHALL BE SENT TO DA DB');
                              },
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 18,
                              ),
                              backgroundColor: Colors.blue[200],
                              elevation: 0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            }));
  }
}
