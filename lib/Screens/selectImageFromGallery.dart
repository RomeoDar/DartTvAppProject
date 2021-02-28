import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/util/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class selectImageFromGallery extends StatefulWidget {

  final String imgUrl;
  selectImageFromGallery(this.imgUrl);
  @override
  _selectImageFromGalleryState createState() => _selectImageFromGalleryState();
}

class _selectImageFromGalleryState extends State<selectImageFromGallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Select Screen To Reflect Image',
            style: TextStyle(fontSize: 15, color: Colors.black // italic
            ),
          ),

        ),
        body: Container(
          height: MediaQuery.of(context).size.height,

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
                                  .map((doc) => new Card(child: ListTile(
                                  onTap: () async {
                                      await FirebaseAuth.instance.currentUser().then((FirebaseUser user) async {
                                        await Firestore.instance
                                            .collection("TvScreen")
                                            .document(doc.documentID)
                                            .setData({'Pictures': widget.imgUrl}, merge: true);
                                      });
                                      showAlertDialog(context,'Image Reflected Successfully');

                                  },
                                  trailing: Icon(Icons.tv,
                                      color: secondryColor, size: 17),
                                  title:
                                  new Text(doc["UserName"]),
                                  subtitle: new Text('Click To Reflect'))))
                                  .toList());
                        }))),


          ],


        )
        )
    );
  }
  showAlertDialog(BuildContext context,String text) {
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
          Navigator.pop(context);
        });
        return alert;
      },
    );
  }
}
