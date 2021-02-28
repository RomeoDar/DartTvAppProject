import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hookup4u/Screens/auth/login.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:hookup4u/models/user_model.dart';


class sidemenu extends StatelessWidget {
  User currentUser;
  sidemenu(this.currentUser);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              '',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage('asset/logo.png'))),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle_rounded),
            title: Text('Profile'),
            onTap: () => {
            /*pushNewScreen(
            context,
            screen: profile(currentUser),
            withNavBar: false, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.sizeUp,
            )*/
            },
          ),
          ListTile(
            leading: Icon(Icons.support_agent_rounded),
            title: Text('Help Center'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Payment Method'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
                'Earn one month subscription for every friend that subscribes'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Terms and Conditions'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              pushNewScreen(
                context,
                screen: Login(),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.sizeUp,
              );
            },
          ),
        ],
      ),
    );
  }
}
