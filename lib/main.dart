import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hookup4u/Screens/Tab.dart';
import 'package:hookup4u/Screens/auth/login.dart';
import 'package:hookup4u/util/color.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
 // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,

  ]).then((_) {
    InAppPurchaseConnection.enablePendingPurchases();
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;
  bool isAuth = false;
  bool isRegistered = false;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future _checkAuth() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.currentUser().then((FirebaseUser user) async {
      print(user);
      if (user != null) {
        await Firestore.instance
            .collection('Users')
            .where('userId', isEqualTo: user.uid)
            .getDocuments()
            .then((QuerySnapshot snapshot) async {
          if (snapshot.documents.length > 0) {
            setState(() {
              isAuth = true;
            });
            print("loggedin ${user.uid}");
          } else {
            setState(() {
              isAuth = false;
            });
          }
        });
      } else {
        setState(() {
          isAuth = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      home: isAuth ? Tabbar() : Login(),
    );
  }
}
