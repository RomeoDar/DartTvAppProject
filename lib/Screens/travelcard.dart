import 'package:flutter/material.dart';
import 'package:hookup4u/Screens/selectImageFromGallery.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

Widget travelCard(String imgUrl,BuildContext context) {
  return Card(
    margin: EdgeInsets.fromLTRB(20,0,10,0),
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
    elevation: 0.0,
    child: InkWell(
      onTap: () {
        pushNewScreen(
          context,
          screen: selectImageFromGallery(imgUrl),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.sizeUp,
        );
      },
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imgUrl),
              fit: BoxFit.fill,
              scale: 2.0,
            )),
        width: 350.0,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 3.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
