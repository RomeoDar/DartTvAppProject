import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hookup4u/util/color.dart';
import 'package:hookup4u/util/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image/image.dart' as i;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math';

class newScreen extends StatefulWidget {

  @override
  _newScreenState createState() => _newScreenState();
}

class _newScreenState extends State<newScreen> {
  Map<String, dynamic> userData = {}; //user personal info
  String username = '';
  bool man = false;
  bool woman = false;
  bool select = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime selecteddate;
  TextEditingController dobctlr = new TextEditingController();
  final TextEditingController aboutCtlr = new TextEditingController();
  final TextEditingController nameCtlr = new TextEditingController();
  final TextEditingController jobCtlr = new TextEditingController();
  //String ImageUrl;
  List<String> ImageUrl = ['', '', '', '',''];

  List selected = [];
  bool selectInterest = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool checkedValue=true;
  //////////////////////////////////////



  Future setUserData(Map<String, dynamic> userData,BuildContext context) async {
    await FirebaseAuth.instance.currentUser().then((FirebaseUser user) async {
      final docRef = await Firestore.instance
          .collection("TvScreen")
          .add(userData);

      await Firestore.instance
          .collection("TvScreen")
          .document(docRef.documentID)
          .setData({'tvID':  docRef.documentID}, merge: true);
    });



    showAlertDialog(context,'Screen Created Successfully');
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Add New Screen",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () async {
                Navigator.pop(context);
              }
          ),
          backgroundColor: Colors.white),

      body: SingleChildScrollView(
        child: Container(
    height: MediaQuery.of(context).size.height,

    child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20,),
            Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Add Your Photo",
                  style: TextStyle(color: Colors.black),
                )),
            Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  "Note: You Can Add only one photo",
                  style: TextStyle(color: secondryColor),
                )),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * .25,
              width: MediaQuery.of(context).size.width,
              child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  childAspectRatio:
                  MediaQuery.of(context).size.aspectRatio * 1.5,
                  crossAxisSpacing: 4,
                  padding: EdgeInsets.all(10),
                  children: List.generate(1, (index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // image: DecorationImage(
                            //     fit: BoxFit.cover,
                            //     image: CachedNetworkImageProvider(
                            //       widget.currentUser.imageUrl[index],
                            //     )),
                          ),
                          child: Stack(
                            children: <Widget>[
                              CachedNetworkImage(
                                height: MediaQuery.of(context)
                                    .size
                                    .height *
                                    .2,
                                fit: BoxFit.cover,
                                imageUrl: ImageUrl[index] !=null ? ImageUrl[index].toString() : 'https://firebasestorage.googleapis.com/v0/b/churpapp-675d2.appspot.com/o/87449e529e536129932639b4b7e3aee6.jpg?alt=media&token=45fa5b54-5666-4236-9ca8-9e55749b0c35',
                                placeholder: (context, url) =>
                                    Center(
                                      child: CupertinoActivityIndicator(
                                        radius: 10,
                                      ),
                                    ),
                                errorWidget:
                                    (context, url, error) => Center(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.error,
                                        color: Colors.black,
                                        size: 25,
                                      ),
                                      Text(
                                        "Select Image",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  //width: 12,
                                  // height: 16,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: primaryColor,
                                    ),
                                    child: InkWell(
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 22,
                                        color: Colors.white,
                                      ),
                                      onTap: () => source(
                                          context,
                                          index,
                                          false),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
            ),
            ListTile(
              title: Text(
                "Tv Screen Name",
                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
              ),
              subtitle: CupertinoTextField(
                controller: nameCtlr,
                cursorColor: primaryColor,
                placeholder: "Add your name",
                padding: EdgeInsets.all(10),
                onChanged: (text) {
                  userData.addAll({'UserName': text});

                },
              ),
            ),

            (nameCtlr.text.length >0)
                ? Padding(
              padding: const EdgeInsets.only(bottom: 40),
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
                                primaryColor1,
                                primaryColor.withOpacity(.8),
                                primaryColor,
                                primaryColor
                              ])),
                      height: MediaQuery.of(context).size.height * .065,
                      width: MediaQuery.of(context).size.width * .75,
                      child: Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                fontSize: 15,
                                color: textColor,
                                fontWeight: FontWeight.bold),
                          ))),
                  onTap: () {
                    Random random = new Random();
                    int randomNumber = random.nextInt(1000);

                    userData.addAll({'UserName': nameCtlr.text});
                    userData.addAll({'code': 'tv@'+randomNumber.toString()});
                    setUserData(userData,context);

                  },
                ),
              ),
            )
                : Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      height: MediaQuery.of(context).size.height * .065,
                      width: MediaQuery.of(context).size.width * .75,
                      child: Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                fontSize: 15,
                                color: secondryColor,
                                fontWeight: FontWeight.bold),
                          ))),
                  onTap: () {
                    CustomSnackbar.snackbar(
                        "Please select one", _scaffoldKey);
                  },
                ),
              ),
            ),


          ],
        ),
        ),
      ),

    );
  }
  Future source(
      BuildContext context,int index, bool isProfilePicture) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
              title: Text(
                  isProfilePicture ? "Update tv picture" : "Add pictures"),
              content: Text(
                "Select source",
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
                          Icons.photo_camera,
                          size: 28,
                        ),
                        Text(
                          " Camera",
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
                          context: context,
                          builder: (context) {
                            getImage(ImageSource.camera,index, context, isProfilePicture);
                            return Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
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
                          " Gallery",
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
                            getImage(ImageSource.gallery,index, context,isProfilePicture);
                            return Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ));
                          });
                    },
                  ),
                ),
              ]);
        });
  }

  Future getImage(
      ImageSource imageSource,int index, context, isProfilePicture) async {
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
            await compressimage(croppedFile),index, isProfilePicture);
      }
    }
    Navigator.pop(context);
  }

  Future uploadFile(File image,int index, isProfilePicture) async {


    Random random = new Random();
    int randomNumber = random.nextInt(10000);

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('users/${randomNumber}/${image.hashCode}.jpg');
    StorageUploadTask uploadTask = storageReference.putFile(image);
    if (uploadTask.isInProgress == true) {}
    if (await uploadTask.onComplete != null) {
      storageReference.getDownloadURL().then((fileURL) async {
        ImageUrl[index]=fileURL.toString();
        if(index==0)
        {
          userData.addAll({
            'Pictures': ImageUrl[0]
          });
        }
        if(index==1)
        {
          userData.addAll({
            'Pictures': FieldValue.arrayUnion([
              ImageUrl[0],
              ImageUrl[1]
            ]),
          });
        }
        if(index==2)
        {
          userData.addAll({
            'Pictures': FieldValue.arrayUnion([
              ImageUrl[0],
              ImageUrl[1],
              ImageUrl[2]
            ]),
          });
        }
        if(index==3)
        {
          userData.addAll({
            'Pictures': FieldValue.arrayUnion([
              ImageUrl[0],
              ImageUrl[1],
              ImageUrl[2],
              ImageUrl[3]
            ]),
          });
        }
        if(index==4)
        {
          userData.addAll({
            'Pictures': FieldValue.arrayUnion([
              ImageUrl[0],
              ImageUrl[1],
              ImageUrl[2],
              ImageUrl[3],
              ImageUrl[4]
            ]),
          });
        }


        try {
          if (isProfilePicture) {
            //currentUser.imageUrl.removeAt(0);
            //currentUser.imageUrl.insert(0, fileURL);
            //print("object");
            //await Firestore.instance
            //  .collection("Users")
            //.document(currentUser.id)
            //.setData({"Pictures": currentUser.imageUrl}, merge: true);
          } else {
            //await Firestore.instance
            //  .collection("Users")
            //.document(currentUser.id)
            // .setData(updateObject, merge: true);
            //widget.currentUser.imageUrl.add(fileURL);
          }
          if (mounted) setState(() {});
        } catch (err) {
          print("Error: $err");
        }
      });
    }
  }

  Future compressimage(File image) async {
    final tempdir = await getTemporaryDirectory();
    final path = tempdir.path;
    i.Image imagefile = i.decodeImage(image.readAsBytesSync());
    final compressedImagefile = File('$path.jpg')
      ..writeAsBytesSync(i.encodeJpg(imagefile, quality: 80));
    // setState(() {

    return compressedImagefile;
    // });
  }

}
