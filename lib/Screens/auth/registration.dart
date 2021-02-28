import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/Tab.dart';
import 'package:hookup4u/Screens/Welcome.dart';
import 'package:hookup4u/util/color.dart';
import 'dart:ui';



class RegistrationScreen extends StatelessWidget {
  static const your_client_id = '000000000000';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static const your_redirect_url =
      'https://churpapp-675d2.firebaseapp.com/__/auth/handler';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController nameCtlr = new TextEditingController();
  final TextEditingController emailCtlr = new TextEditingController();
  final TextEditingController passCtlr = new TextEditingController();
  final TextEditingController cpassCtlr = new TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;


  Future<FirebaseUser> handleSignUp(name, email, password,cpassword,BuildContext context) async {

    if(password==cpassword)
      {
        try {
          AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);
            await Firestore.instance.collection("Users").document(result.user.uid).setData(
              {
                'userId': result.user.uid,
                'UserName': name,
                /*'Pictures': FieldValue.arrayUnion([
                  "https://firebasestorage.googleapis.com/v0/b/churpapp-675d2.appspot.com/o/87449e529e536129932639b4b7e3aee6.jpg?alt=media&token=45fa5b54-5666-4236-9ca8-9e55749b0c35"
                ]),*/
                'Email': result.user.email,
                'timestamp': FieldValue.serverTimestamp()
              },
              merge: true,
            );
          Navigator.pushReplacement(
              context, CupertinoPageRoute(builder: (context) => Tabbar()));
          //showAlertDialog(context,'Account Successfully Created');


        } on AuthException catch (e) {
          if (e.code == 'weak-password') {
            showAlertDialog(context,'The password provided is too weak.');
            print('The password provided is too weak.');
          }

          else if (e.code == 'ERROR_INVALID_EMAIL') {
            showAlertDialog(context,'Email is invalid.');
          }
            else if (e.code == 'email-already-in-use') {
            showAlertDialog(context,'The account already exists for that email.');
            print('The account already exists for that email.');
          }
        } catch (e) {
          showAlertDialog(context,'Error Try Again');
          print(e);
        }
      }
    else{
      showAlertDialog(context,'Password Doesn\'t Match');
    }


    //AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    //final FirebaseUser user = result.user;
    //assert (user != null);
    //assert (await user.getIdToken() != null);
    //return user;

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
                  "asset/bgr.png",
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      Positioned(
                        left: 20.0,
                        top: 35,
                        child: Container(
                            height: 50,
                            width: 50,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                // do something
                              },
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child: Center(
                          child: Text(
                            'Registration',
                            style: TextStyle(
                                fontSize: 15, color: Colors.white // italic
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 150,
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
                        height: MediaQuery.of(context).size.height / 1,
                        child: Column(children: [
                          SizedBox(height: 20),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                children: [
                                  Icon(Icons.supervised_user_circle_sharp,
                                      color: secondryColor, size: 17),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    //"Name ${widget.currentUser.name}",
                                    "Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: secondryColor),
                                  ),
                                ],
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: CupertinoTextField(
                                controller: nameCtlr,
                                cursorColor: primaryColor,
                                //maxLines: 1,
                                //minLines: 3,
                                placeholder: "Your Name",
                                padding: EdgeInsets.all(10),
                                onChanged: (text) {},
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                children: [
                                  Icon(Icons.email,
                                      color: secondryColor, size: 17),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: CupertinoTextField(
                                controller: emailCtlr,
                                cursorColor: primaryColor,
                                //maxLines: 1,
                                //minLines: 3,
                                placeholder: "Your Email",
                                padding: EdgeInsets.all(10),
                                onChanged: (text) {},
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
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
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                children: [
                                  Icon(Icons.vpn_key,
                                      color: secondryColor, size: 17),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    //"Name ${widget.currentUser.name}",
                                    "Confirm Password",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: secondryColor),
                                  ),
                                ],
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: CupertinoTextField(
                                obscureText: true,
                                controller: cpassCtlr,
                                cursorColor: primaryColor,
                                //maxLines: 1,
                                //minLines: 3,
                                placeholder: "********",
                                padding: EdgeInsets.all(10),
                                onChanged: (text) {},
                              )),
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
                                  child: Text("Create Account",
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold))),
                            ),
                            onTap: () async {
                              showAlertDialog1(context);
                              handleSignUp(nameCtlr.text, emailCtlr.text,passCtlr.text,cpassCtlr.text,context);
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
          Container(margin: EdgeInsets.only(left: 5),child:Text("Creating Account.." )),
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
