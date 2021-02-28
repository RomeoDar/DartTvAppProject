import 'dart:io';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hookup4u/Screens/Tab.dart';
import 'package:hookup4u/Screens/Welcome.dart';
import 'package:hookup4u/Screens/auth/emailLogin.dart';
import 'package:hookup4u/Screens/auth/otp.dart';
import 'package:hookup4u/Screens/auth/registration.dart';
import 'package:hookup4u/models/custom_web_view.dart';
import 'package:hookup4u/util/color.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hookup4u/models/user_model.dart';
import 'package:hookup4u/util/color.dart';
import 'package:swipe_stack/swipe_stack.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:in_app_purchase/in_app_purchase.dart';


class Login extends StatelessWidget {
  static const your_client_id = '000000000000';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static const your_redirect_url =
      'https://churpapp-675d2.firebaseapp.com/__/auth/handler';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
              color: Colors.white,
          child: ListView(
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    child: Swiper(
                      key: UniqueKey(),
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index2) {
                        return Padding(
                          padding: EdgeInsets.only(left: 30,right: 30,top: 30),
                            child: FittedBox(
                          child: Image.asset('asset/logo.png'),
                          fit: BoxFit.fill,
                        ),
                        );
                      },
                      itemCount: 1,
                      loop: false,
                    ),
                  ),
                ],
              ),
              Column(children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                /*Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: InkWell(
                        child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(25),
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      primaryColor1,
                                        primaryColor.withOpacity(.8),
                                        primaryColor,
                                        primaryColor
                                    ])),
                            height: MediaQuery.of(context).size.height * .065,
                            width: MediaQuery.of(context).size.width * .8,
                            child: Center(
                                child: Text(
                              "LOG IN WITH FACEBOOK",
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold),
                            ))),
                        onTap: () async {
                          showDialog(
                              context: context,
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  child: Center(
                                      child: CupertinoActivityIndicator(
                                    key: UniqueKey(),
                                    radius: 20,
                                    animating: true,
                                  ))));
                          await handleFacebookLogin(context).then((user) {
                            navigationCheck(user, context);
                          }).then((_) {
                            Navigator.pop(context);
                          }).catchError((e) {
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                  ),
                ),*/
                SizedBox(
                  height: 10,
                ),
                Platform.isIOS
                    ? Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10.0, left: 30, right: 30),
                        child: AppleSignInButton(
                          cornerRadius: 50,
                          type: ButtonType.defaultButton,
                          onPressed: () async {
                            final FirebaseUser currentUser =
                                await handleAppleLogin().catchError((onError) {
                              SnackBar snackBar =
                                  SnackBar(content: Text(onError));
                              _scaffoldKey.currentState.showSnackBar(snackBar);
                            });
                            if (currentUser != null) {
                              print(
                                  'usernaem ${currentUser.displayName} \n photourl ${currentUser.photoUrl}');
                              await _setDataUser(currentUser);
                              navigationCheck(currentUser, context);
                            }
                          },
                        ),
                      )
                    : Container(),
                /*OutlineButton(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .065,
                    width: MediaQuery.of(context).size.width * .75,
                    child: Center(
                        child: Text("LOG IN WITH PHONE NUMBER",
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold))),
                  ),
                  borderSide: BorderSide(
                      width: 1, style: BorderStyle.solid, color: primaryColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  onPressed: ()
                ),*/
                SizedBox(
                  height: 10,
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
                    width: MediaQuery.of(context).size.width * .85,
                    child:Center(
                        child: Text("Login",
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold))),),
                  onTap: () {
                    bool updateNumber = false;
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => emailLogin()));
                  },
                ),
                SizedBox(
                  height: 10,
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
                    width: MediaQuery.of(context).size.width * .85,
                    child:Center(
                        child: Text("Sign Up",
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold))),),
                  onTap: () {
                    bool updateNumber = false;
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => RegistrationScreen()));
                  },
                ),

              ]),
            ],
          ),
        ),
      ),
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

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
              context, CupertinoPageRoute(builder: (context) => Tabbar()));
        }
      } else {
        await _setDataUser(currentUser);
        Navigator.push(
            context, CupertinoPageRoute(builder: (context) => Tabbar()));
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
      'phoneNumber': user.phoneNumber,
      'timestamp': FieldValue.serverTimestamp()
    },
    merge: true,
  );
}
