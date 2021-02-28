import 'dart:io';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/Tab.dart';
import 'package:hookup4u/Screens/Welcome.dart';
import 'package:hookup4u/Screens/auth/registration.dart';
import 'package:hookup4u/models/custom_web_view.dart';
import 'package:hookup4u/util/color.dart';
import 'dart:ui';
import 'dart:async';
import 'package:hookup4u/models/user_model.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:hookup4u/models/user_model.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:hookup4u/util/color.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class emailLogin extends StatefulWidget {
  @override
  _emailLoginState createState() => _emailLoginState();
}
class _emailLoginState extends State<emailLogin> {

  static const your_client_id = '000000000000';
  static const your_redirect_url =
      'https://churpapp-675d2.firebaseapp.com/__/auth/handler';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController nameCtlr = new TextEditingController();
  final TextEditingController passCtlr = new TextEditingController();
  User currentUser;
  CollectionReference docRef = Firestore.instance.collection('Users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<User> users = [];



  bool isLoading = true;
  bool isAuth = false;
  bool isRegistered = false;

  String abc;
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
            abc=user.uid.toString();
            if (snapshot.documents[0].data['location'] != null) {
              setState(() {
                isRegistered = true;
                isLoading = false;
              });
            } else {
              setState(() {
                isAuth = true;
                isLoading = false;
              });
            }
            print("loggedin ${user.uid}");
          } else {
            setState(() {
              isLoading = false;
            });
          }
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                colorFilter:
                    //ColorFilter.mode(Colors.yellowAccent[100], BlendMode.colorBurn),
                    ColorFilter.mode(Colors.grey[500], BlendMode.modulate),
                image: AssetImage(
                  "asset/bg.png",
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(children: [
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 45,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          ' Welcome',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '  to the ABC App',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white,
                    ),
                    height: MediaQuery.of(context).size.height / 2,
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              Icon(Icons.email, color: secondryColor, size: 17),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                //"Name ${widget.currentUser.name}",
                                "Email",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: secondryColor),
                              ),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: CupertinoTextField(
                            controller: nameCtlr,
                            cursorColor: primaryColor,
                            //maxLines: 1,
                            //minLines: 3,
                            placeholder: "Your Name",
                            padding: EdgeInsets.all(10),
                            onChanged: (text) {},
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              Icon(Icons.vpn_key,
                                  color: secondryColor, size: 17),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                //"Name ${widget.currentUser.name}",
                                "Password",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: secondryColor),
                              ),
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: CupertinoTextField(
                            obscureText: true,
                            controller: passCtlr,
                            cursorColor: primaryColor,
                            //maxLines: 1,
                            //minLines: 3,
                            placeholder: "********",
                            padding: EdgeInsets.all(10),
                            onChanged: (text) {},
                          )),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text("Forget Password ?",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    primaryColor1,
                                    primaryColor.withOpacity(.8),
                                    primaryColor,
                                    primaryColor,
                                  ])),
                          height: MediaQuery.of(context).size.height * .065,
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Center(
                              child: Text("Sign in",
                                  style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.bold))),
                        ),
                        onTap: () async {
                          showAlertDialog1(context);
                          try {
                            AuthResult result =
                                await _auth.signInWithEmailAndPassword(
                                    email: nameCtlr.text, password: passCtlr.text);
                            Navigator.pushReplacement(
                                context, CupertinoPageRoute(builder: (context) => Tabbar()));
                          } on AuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showAlertDialog(context,'No user found for that email.');
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              showAlertDialog(context,'Wrong password provided for that user.');
                              print('Wrong password provided for that user.');
                            }
                          } catch (e) {
                            if (e.code == 'user-not-found') {
                              showAlertDialog(context,'No user found for that email.');
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              showAlertDialog(context,'Wrong password provided for that user.');
                              print('Wrong password provided for that user.');
                            }
                            else
                              {
                            showAlertDialog(context, 'Error Try Again');
                            print(e);
                              }
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        child: Container(
                          height: MediaQuery.of(context).size.height * .065,
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Center(
                              child: Text("Create An Account",
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.bold))),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => RegistrationScreen()));
                        },
                      ),
                    ]),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
  showAlertDialog1(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 5),child:Text("Login...Please wait" )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
  showAlertDialog(BuildContext context,String text) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("My title"),
      content: Text(text),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
        });
        return alert;
      },
    );
  }
  Future<FirebaseUser> handleFacebookLogin(context) async {
    FirebaseUser user;
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CustomWebView(
                selectedUrl:
                    'https://www.facebook.com/dialog/oauth?client_id=$your_client_id&redirect_uri=$your_redirect_url&response_type=token&scope=email,public_profile,',
              ),
          maintainState: true),
    );
    if (result != null) {
      try {
        final facebookAuthCred =
            FacebookAuthProvider.getCredential(accessToken: result);
        user =
            (await FirebaseAuth.instance.signInWithCredential(facebookAuthCred))
                .user;

        print('user $user');
      } catch (e) {
        print('Error $e');
      }
    }
    return user;
  }

  Future navigationCheck(FirebaseUser currentUser, context) async {
    await Firestore.instance
        .collection('Users')
        .where('userId', isEqualTo: currentUser.uid)
        .getDocuments()
        .then((QuerySnapshot snapshot) async {
      if (snapshot.documents.length > 0) {
        if (snapshot.documents[0].data['location'] != null) {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => Tabbar()));
        } else {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => Welcome()));
        }
      } else {
        await _setDataUser(currentUser);
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => Welcome()));
      }
    });
  }

  Future<FirebaseUser> handleAppleLogin() async {
    FirebaseUser user;
    if (await AppleSignIn.isAvailable()) {
      try {
        final AuthorizationResult result = await AppleSignIn.performRequests([
          AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
        ]).catchError((onError) {
          print("inside $onError");
        });

        switch (result.status) {
          case AuthorizationStatus.authorized:
            try {
              print("successfull sign in");
              final AppleIdCredential appleIdCredential = result.credential;

              OAuthProvider oAuthProvider =
                  new OAuthProvider(providerId: "apple.com");
              final AuthCredential credential = oAuthProvider.getCredential(
                idToken: String.fromCharCodes(appleIdCredential.identityToken),
                accessToken:
                    String.fromCharCodes(appleIdCredential.authorizationCode),
              );

              user = (await _auth.signInWithCredential(credential)).user;
              print("signed in as " + user.toString());
            } catch (error) {
              print("Error $error");
            }
            break;
          case AuthorizationStatus.error:
            // do something

            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('An error occured. Please Try again.'),
              duration: Duration(seconds: 8),
            ));

            break;

          case AuthorizationStatus.cancelled:
            print('User cancelled');
            break;
        }
      } catch (error) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('$error.'),
          duration: Duration(seconds: 8),
        ));
        print("error with apple sign in");
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Apple SignIn is not available for your device'),
        duration: Duration(seconds: 8),
      ));
    }
    return user;
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 29 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 60);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * 0.6, size.height - 15 - 50);
    var firstControlPoint = Offset(size.width * .25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 40);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * .7, size.height - 40);
    var firstControlPoint = Offset(size.width * .25, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

Future _setDataUser(FirebaseUser user) async {
  await Firestore.instance.collection("Users").document(user.uid).setData(
    {
      'userId': user.uid,
      'UserName': user.displayName,
      'Pictures': FieldValue.arrayUnion([user.photoUrl]),
      'phoneNumber': user.phoneNumber,
      'timestamp': FieldValue.serverTimestamp()
    },
    merge: true,
  );
}
