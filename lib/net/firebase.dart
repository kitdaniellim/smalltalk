import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

Future<void> register({String displayName, String url}) {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  bool hasUrl = url != null || url != '';
  users.add({
    'displayName': displayName,
    'uid': uid,
    'photoURL': hasUrl ? url : "null"
  });
}