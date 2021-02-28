import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/models/user_model.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


class profile extends StatefulWidget {

  User currentUser1;
  profile(this.currentUser1);
  //Tabbar();
  @override
  profileState createState() => profileState();
}

//_
class profileState extends State<profile> {
  CollectionReference docRef = Firestore.instance.collection('Users');
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User currentUser;
  List<User> users = [];


  PersistentTabController _controller;
  bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
    _getCurrentUser();
  }
  _getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return docRef.document("${user.uid}").snapshots().listen((data) async {
      currentUser = User.fromDocument(data);
      if (mounted) setState(() {});
      users.clear();
      return currentUser;
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
        'Profile',
    style: TextStyle(fontSize: 15, color: Colors.black // italic
    ),
    ),

    ),
    body: Column(
    children: [
      SizedBox(height: 70,),
      Center(child: Text('Name: '+widget.currentUser1.name),),
      SizedBox(height: 20,),
      Center(child: Text('Name: '+widget.currentUser1.Email),),
    ],
    ));
  }
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
