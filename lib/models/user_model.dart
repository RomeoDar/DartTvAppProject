import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class User {
  final String id;
  final String Email;
  final int lastSeen;
  final String code;
  final String tvID;
  final String activity;
  final String name;
  final bool isBlocked;
  String address;
  final Map coordinates;
  final List sexualOrientation;
  final String gender;
  final String showGender;
  final int age;
  final String phoneNumber;
  int maxDistance;
  Timestamp lastmsg;
  final Map ageRange;
  final Map editInfo;
  List imageUrl = [];
  var distanceBW;
  User({
    this.id,
    this.age,
    this.Email,
    this.code,
    this.tvID,
    this.address,
    this.lastSeen,
    this.activity,
    this.isBlocked,
    this.coordinates,
    this.name,
    this.imageUrl,
    this.phoneNumber,
    this.lastmsg,
    this.gender,
    this.showGender,
    this.ageRange,
    this.maxDistance,
    this.editInfo,
    this.distanceBW,
    this.sexualOrientation,
  });
  factory User.fromDocument(DocumentSnapshot doc) {
    // DateTime date = DateTime.parse(doc["user_DOB"]);
    return User(
        id: doc['userId'],
        lastSeen: doc['last_seen'],
        tvID: doc['tvID'],
        Email: doc['Email'],
        code: doc['code'],
        activity: doc['activity'],
        isBlocked: doc['isBlocked'] != null ? doc['isBlocked'] : false,
        phoneNumber: doc['phoneNumber'],
        name: doc['UserName'],
        editInfo: doc['editInfo'],
        ageRange: doc['age_range'],
        showGender: doc['showGender'],
        maxDistance: doc['maximum_distance'],
        sexualOrientation: doc['sexualOrientation']['orientation'] ?? "",
        age: ((DateTime.now()
                    .difference(DateTime.parse(doc["user_DOB"]))
                    .inDays) /
                365.2425)
            .truncate(),
        address: doc['location']['address'],
        coordinates: doc['location'],
        // university: doc['editInfo']['university'],
        imageUrl: doc['Pictures'] != null
            ? List.generate(doc['Pictures'].length, (index) {
                return doc['Pictures'][index];
              })
            : null);
  }
}
