import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

bool register({required String displayName, required String url}) {

   CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  bool hasUrl = url != '';
  List<String> createSearch(String query) {
    List<String> caseSearch = [];
    String temp = "";
    query = query.toLowerCase();
    for(int i = 0; i < query.length; i++) {
      temp = temp + query[i];
      caseSearch.add(temp);
    }

    return caseSearch;
  }
  users.add({
    'displayName': displayName,
    'search': createSearch(displayName),
    'uid': uid,
    'photoURL': hasUrl ? url : "null"
  });
  return true;
}