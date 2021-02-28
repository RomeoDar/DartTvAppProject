import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hookup4u/Screens/ImageScreen.dart';
import 'package:hookup4u/Screens/Welcome.dart';
import 'package:hookup4u/models/user_model.dart';
import 'package:hookup4u/util/color.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Tabbar extends StatefulWidget {

  //Tabbar();
  @override
  TabbarState createState() => TabbarState();
}

//_
class TabbarState extends State<Tabbar> {
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

  int _currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> _buildScreens() {
    return [
      Welcome(),
      ImageScreen(),
      //ChatScreen(currentUser, matches, newmatches),
      //Matchcreen(currentUser, matches, newmatches, churpReq, newchurpReq),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.tv),
        title: "Screens",
        activeColor: primaryColor,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.qr_code),
        title: ("Art Gallery"),
        activeColor: primaryColor,
        inactiveColor: Colors.grey,
      ),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Exit'),
              content: Text('Do you want to exit the app?'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                FlatButton(
                  onPressed: () => SystemChannels.platform
                      .invokeMethod('SystemNavigator.pop'),
                  child: Text('Yes'),
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        body: PersistentTabView(
                    context,
                    controller: _controller,
                    screens: _buildScreens(),
                    items: _navBarsItems(),
                    confineInSafeArea: true,
                    backgroundColor: Colors.white,
                    handleAndroidBackButtonPress: true,
                    resizeToAvoidBottomInset: true,
                    stateManagement: true,
                    navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
                        ? 0.0
                        : kBottomNavigationBarHeight,
                    hideNavigationBarWhenKeyboardShows: true,
                    margin: EdgeInsets.all(0.0),
                    popActionScreens: PopActionScreensType.once,
                    bottomScreenMargin: 0.0,

                    onWillPop: () async {
                      await showDialog(
                        context: context,
                        useSafeArea: true,
                        builder: (context) => Container(
                          height: 50.0,
                          width: 50.0,
                          color: Colors.white,
                          child: RaisedButton(
                            child: Text("Close"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                      return false;
                    },
                    hideNavigationBar: _hideNavBar,
                    decoration: NavBarDecoration(
                        colorBehindNavBar: Colors.indigo,
                        borderRadius: BorderRadius.circular(0.0)),
                    popAllScreensOnTapOfSelectedTab: true,
                    itemAnimationProperties: ItemAnimationProperties(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.ease,
                    ),
                    screenTransitionAnimation: ScreenTransitionAnimation(
                      animateTabTransition: true,
                      curve: Curves.ease,
                      duration: Duration(milliseconds: 200),
                    ),
                    navBarStyle: NavBarStyle
                        .style6, // Choose the nav bar style with this property
                  ),
      ),
    );
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
