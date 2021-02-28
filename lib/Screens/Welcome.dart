import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/ChangeScreen.dart';
import 'package:hookup4u/Screens/newScreen.dart';
import 'package:hookup4u/Screens/sidemenu.dart';
import 'package:hookup4u/util/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:hookup4u/models/user_model.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  CollectionReference docRef = Firestore.instance.collection('Users');
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User currentUser;
  List<User> users = [];

  @override
  void initState() {
    super.initState();
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

    return Scaffold(
        backgroundColor: Colors.white,
        drawer: sidemenu(currentUser),
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'All Tv Screens',
            style: TextStyle(fontSize: 15, color: Colors.black // italic
                ),
          ),
        ),
        body: Container(

            child: Column(
              children: <Widget>[
                Expanded(
                    child: SizedBox(
                        height: 500.0,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection("TvScreen")
                                //.where("quantity", isGreaterThanOrEqualTo: 1)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData)
                                return new Text("There is no Data");
                              return new ListView(
                                  children: snapshot.data.documents
                                      .map((doc) => new Card(
                                          child: ListTile(
                                              onTap: () {
                                                pushNewScreen(
                                                  context,
                                                  screen: ChangeScreen(
                                                      doc["tvID"],
                                                      doc["UserName"],
                                                      doc["Pictures"]),
                                                  withNavBar:
                                                      false, // OPTIONAL VALUE. True by default.
                                                  pageTransitionAnimation:
                                                      PageTransitionAnimation
                                                          .sizeUp,
                                                );
                                              },
                                              leading: SizedBox(
                                                height: 50.0,
                                                width:
                                                    90.0, // fixed width and height
                                                child: CachedNetworkImage(
                                                  imageUrl: doc["Pictures"],
                                                  placeholder: (context, url) =>
                                                      new CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          new Icon(Icons.error),
                                                ),
                                              ),
                                              trailing: Icon(Icons.tv,
                                                  color: secondryColor,
                                                  size: 17),
                                              title: new Text(doc["UserName"]),
                                              subtitle: new Text('Code: ' +
                                                  doc["code"].toString()))))
                                      .toList());
                            }))),
                Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    //primaryColor1,
                                    //primaryColor.withOpacity(.8),
                                    primaryColor,
                                    primaryColor
                                  ])),
                          height: MediaQuery.of(context).size.height * .065,
                          width: MediaQuery.of(context).size.width * .75,
                          child: Center(
                              child: Text(
                            "Add New Screen",
                            style: TextStyle(
                                fontSize: 15,
                                color: textColor,
                                fontWeight: FontWeight.bold),
                          ))),
                      onTap: () async {
                        pushNewScreen(
                          context,
                          screen: newScreen(),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.sizeUp,
                        );
                      },
                    ),
                  ),
                ),
              ],
            )));
  }
}
