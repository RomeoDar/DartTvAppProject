import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/travelcard.dart';
import 'package:hookup4u/util/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:ui';
import 'dart:io';
import 'package:image/image.dart' as i;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math';

class ImageScreen extends StatefulWidget {
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  Map<String, dynamic> userData = {};
  List<String> ImageUrl = ['', '', '', '', ''];
  final FirebaseAuth auth = FirebaseAuth.instance;
  String uid;
  void inputData() async {
    final FirebaseUser user = await auth.currentUser();
    uid = user.uid;
    // here you write the codes to input the data into firestore
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      inputData();
      (context as Element).reassemble();
    });
    inputData();
    (context as Element).reassemble();
  }

  @override
  Widget build(BuildContext context) {
    inputData();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Art Gallery',
            style: TextStyle(fontSize: 15, color: Colors.black // italic
                ),
          ),
        ),
        floatingActionButton: Container(
          padding: EdgeInsets.only(bottom: 50.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
              onPressed: () => source(context, false),
              icon: Icon(Icons.add),
              label: Text("Add Photos"),
            ),
          ),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,

            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Just For You',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900, // light
                    fontStyle: FontStyle.italic, // italic
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 200.0,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection("Users")
                            .where("userId", isEqualTo: uid)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          try {
                            if (!snapshot.hasData)
                              return new Text("There is no Data");
                            print(snapshot.data.documents.length);
                            print(snapshot.data.documents.length);
                            print(snapshot.data.documents.length);
                            print(snapshot.data.documents.length);
                            print(snapshot.data.documents.length);
                            int len =
                                snapshot.data.documents.first['Pictures'].length;
                            if (len == 0) {
                              return Text("No Image Data Found");
                            } else if (len == 1) {
                              return new ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [0],
                                      context),
                                ],
                              );
                            } else if (len == 2) {
                              return new ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [0],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [1],
                                      context),
                                ],
                              );
                            } else if (len == 3) {
                              return new ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [0],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [1],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [2],
                                      context),
                                ],
                              );
                            } else if (len == 4) {
                              return new ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [0],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [1],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [2],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [3],
                                      context),
                                ],
                              );
                            } else if (len == 5) {
                              return new ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [0],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [1],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [2],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [3],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [4],
                                      context),
                                ],
                              );
                            } else if (len == 6) {
                              return new ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [0],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [1],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [2],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [3],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [4],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [5],
                                      context),
                                ],
                              );
                            } else if (len == 7) {
                              return new ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [0],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [1],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [2],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [3],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [4],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [5],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [6],
                                      context),
                                ],
                              );
                            } else if (len == 8) {
                              return new ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [0],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [1],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [2],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [3],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [4],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [5],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [6],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [7],
                                      context),
                                ],
                              );
                            } else if (len == 9) {
                              return new ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [0],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [1],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [2],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [3],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [4],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [5],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [6],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [7],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [8],
                                      context),
                                ],
                              );
                            } else if (len == 10) {
                              return new ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  //Here you can add what ever you want
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [0],
                                      context),

                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [1],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [2],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [3],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [4],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [5],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [6],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [7],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [8],
                                      context),
                                  travelCard(
                                      snapshot.data.documents.first["Pictures"]
                                      [9],
                                      context),
                                ],
                              );
                            }
                          } on Exception catch (exception) {
                            return new Text("There is no Data");
                          } catch (error) {
                            return new Text("There is no Data");
                          }

                        })),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  ' Local Artists',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900, // light
                    fontStyle: FontStyle.italic, // italic
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 200.0,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection("Users")
                            .where("userId", isEqualTo: uid)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          try{
                          if (!snapshot.hasData)
                            return new Text("There is no Data");
                          print(snapshot.data.documents.length);
                          print(snapshot.data.documents.length);
                          print(snapshot.data.documents.length);
                          print(snapshot.data.documents.length);
                          print(snapshot.data.documents.length);
                          int len = snapshot
                              .data.documents.first['LocalArtist'].length;

                          if (len == 0) {
                            return Text("No Image Data Found");
                          } else if (len == 1) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [0],
                                    context),
                              ],
                            );
                          } else if (len == 2) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [1],
                                    context),
                              ],
                            );
                          } else if (len == 3) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [2],
                                    context),
                              ],
                            );
                          } else if (len == 4) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [2],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [3],
                                    context),
                              ],
                            );
                          } else if (len == 5) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [2],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [3],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [4],
                                    context),
                              ],
                            );
                          } else if (len == 6) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [2],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [3],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [4],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [5],
                                    context),
                              ],
                            );
                          } else if (len == 7) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [2],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [3],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [4],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [5],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [6],
                                    context),
                              ],
                            );
                          } else if (len == 8) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [2],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [3],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [4],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [5],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [6],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [7],
                                    context),
                              ],
                            );
                          } else if (len == 9) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [2],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [3],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [4],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [5],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [6],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [7],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [8],
                                    context),
                              ],
                            );
                          } else if (len == 10) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                //Here you can add what ever you want
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [0],
                                    context),

                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [2],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [3],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [4],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [5],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [6],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [7],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [8],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["LocalArtist"]
                                        [9],
                                    context),
                              ],
                            );
                          }
                          } on Exception catch (exception) {
                            return new Text("There is no Data");
                          } catch (error) {
                            return new Text("There is no Data");
                          }
                        })),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Top Creations - Weekly',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900, // light
                    fontStyle: FontStyle.italic, // italic
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 200.0,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection("Users")
                            .where("userId", isEqualTo: uid)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          try{
                          if (!snapshot.hasData)
                            return new Text("There is no Data");
                          print(snapshot.data.documents.length);
                          print(snapshot.data.documents.length);
                          print(snapshot.data.documents.length);
                          print(snapshot.data.documents.length);
                          print(snapshot.data.documents.length);
                          int len = snapshot
                              .data.documents.first['TopCreation'].length;

                          if (len == 0) {
                            return Text("No Image Data Found");
                          } else if (len == 1) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [0],
                                    context),
                              ],
                            );
                          } else if (len == 2) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [1],
                                    context),
                              ],
                            );
                          } else if (len == 3) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [2],
                                    context),
                              ],
                            );
                          } else if (len == 4) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [2],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [3],
                                    context),
                              ],
                            );
                          } else if (len == 5) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [2],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [3],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [4],
                                    context),
                              ],
                            );
                          } else if (len == 6) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [2],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [3],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [4],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [5],
                                    context),
                              ],
                            );
                          } else if (len == 7) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [2],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [3],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [4],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [5],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [6],
                                    context),
                              ],
                            );
                          } else if (len == 8) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [2],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [3],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [4],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [5],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [6],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [7],
                                    context),
                              ],
                            );
                          } else if (len == 9) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [2],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [3],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [4],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [5],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [6],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [7],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [8],
                                    context),
                              ],
                            );
                          } else if (len == 10) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                //Here you can add what ever you want
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [2],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [3],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [4],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [5],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [6],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [7],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [8],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["TopCreation"]
                                        [9],
                                    context),
                              ],
                            );
                          }
                          } on Exception catch (exception) {
                            return new Text("There is no Data");
                          } catch (error) {
                            return new Text("There is no Data");
                          }
                        })),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Own Gallery',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900, // light
                    fontStyle: FontStyle.italic, // italic
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 200.0,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection("Users")
                            .where("userId", isEqualTo: uid)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          try{
                          if (!snapshot.hasData)
                            return new Text("There is no Data");
                          print(snapshot.data.documents.length);
                          print(snapshot.data.documents.length);
                          print(snapshot.data.documents.length);
                          print(snapshot.data.documents.length);
                          print(snapshot.data.documents.length);
                          int len = snapshot
                              .data.documents.first['OwnGallery'].length;

                          if (len == 0) {
                            return Text("No Image Data Found");
                          } else if (len == 1) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [0],
                                    context),
                              ],
                            );
                          } else if (len == 2) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [1],
                                    context),
                              ],
                            );
                          } else if (len == 3) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [2],
                                    context),
                              ],
                            );
                          } else if (len == 4) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [2],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [3],
                                    context),
                              ],
                            );
                          } else if (len == 5) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [2],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [3],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [4],
                                    context),
                              ],
                            );
                          } else if (len == 6) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [2],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [3],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [4],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [5],
                                    context),
                              ],
                            );
                          } else if (len == 7) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [2],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [3],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [4],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [5],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [6],
                                    context),
                              ],
                            );
                          } else if (len == 8) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [2],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [3],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [4],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [5],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [6],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [7],
                                    context),
                              ],
                            );
                          } else if (len == 9) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [0],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [2],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [3],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [4],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [5],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [6],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [7],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [8],
                                    context),
                              ],
                            );
                          } else if (len == 10) {
                            return new ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                //Here you can add what ever you want
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [0],
                                    context),

                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [1],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [2],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [3],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [4],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [5],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [6],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [7],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [8],
                                    context),
                                travelCard(
                                    snapshot.data.documents.first["OwnGallery"]
                                        [9],
                                    context),
                              ],
                            );
                          }
                          } on Exception catch (exception) {
                            return new Text("There is no Data");
                          } catch (error) {
                            return new Text("There is no Data");
                          }
                        })),
                SizedBox(
                  height: 100,
                ),
              ],
            ))));
  }

  Future source(BuildContext context, bool isProfilePicture) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
              title:
                  Text(isProfilePicture ? "Update tv picture" : "Add pictures"),
              content: Text(
                "Select Category",
              ),
              insetAnimationCurve: Curves.decelerate,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.photo_library,
                          size: 28,
                        ),
                        Text(
                          "Just For You",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            getImage('Pictures', ImageSource.gallery, context,
                                isProfilePicture);
                            return Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ));
                          });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.photo_library,
                          size: 28,
                        ),
                        Text(
                          "Local Artist",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            getImage('LocalArtist', ImageSource.gallery,
                                context, isProfilePicture);
                            return Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ));
                          });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.photo_library,
                          size: 28,
                        ),
                        Text(
                          "Top Creation",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            getImage('TopCreation', ImageSource.gallery,
                                context, isProfilePicture);
                            return Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ));
                          });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.photo_library,
                          size: 28,
                        ),
                        Text(
                          "Own Gallery",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            getImage('OwnGallery', ImageSource.gallery, context,
                                isProfilePicture);
                            return Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ));
                          });
                    },
                  ),
                ),
              ]);
        });
  }

  Future getImage(
      String cat, ImageSource imageSource, context, isProfilePicture) async {
    var image = await ImagePicker.pickImage(source: imageSource);
    if (image != null) {
      File croppedFile = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: [CropAspectRatioPreset.ratio16x9],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Crop',
              toolbarColor: primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.ratio16x9,
              lockAspectRatio: true),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
      if (croppedFile != null) {
        await uploadFile(
            await compressimage(croppedFile), isProfilePicture, cat);
      }
    }
    Navigator.pop(context);
  }

  Future uploadFile(File image, isProfilePicture, String cat) async {
    Random random = new Random();
    int randomNumber = random.nextInt(10000);
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('users/${randomNumber}/${image.hashCode}.jpg');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    if (uploadTask.isInProgress == true) {}
    if (await uploadTask.onComplete != null) {
      storageReference.getDownloadURL().then((fileURL) async {
        ImageUrl[0] = fileURL.toString();
        userData.addAll({
          cat: FieldValue.arrayUnion([
            ImageUrl[0],
          ]),
        });
        setUserData(userData);
      });
    }
  }

  Future setUserData(Map<String, dynamic> userData) async {
    await FirebaseAuth.instance.currentUser().then((FirebaseUser user) async {
      await Firestore.instance
          .collection("Users")
          .document(user.uid)
          .setData(userData, merge: true);
    });
  }

  Future compressimage(File image) async {
    final tempdir = await getTemporaryDirectory();
    final path = tempdir.path;
    i.Image imagefile = i.decodeImage(image.readAsBytesSync());
    final compressedImagefile = File('$path.jpg')
      ..writeAsBytesSync(i.encodeJpg(imagefile, quality: 80));
    return compressedImagefile;
  }
}
