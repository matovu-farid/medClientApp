import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

part 'hospitaluser.g.dart';

@JsonSerializable()
class HospitalUser {
  String hospitalName;
  String hospitalLocation;
  String password;

  HospitalUser();

  factory HospitalUser.fromJson(Map<String, dynamic> json) =>
      _$HospitalUserFromJson(json);

  @override
  String toString() {
    return 'HospitalUser{hospitalName: $hospitalName, hospitalLocation: $hospitalLocation, password: $password}';
  }

  Map<String, dynamic> toJson() => _$HospitalUserToJson(this);
}

class SendHospitalUser {
  CollectionReference hospitalUser =
  FirebaseFirestore.instance.collection('hospitalUser');
  List createHospitalUserList() {
    final hospitalUserList = [];
    for (int i = 0; i < 5; i++) {
       var hospitalUser= HospitalUser()
        ..hospitalName = lipsum.createWord()
        ..hospitalLocation = lipsum.createWord()
        ..password = lipsum.createWord();
      hospitalUserList.add(
        json.encode(hospitalUser.toJson())
      );
      return hospitalUserList;
    }
  }
  sendToFireBase(){
    hospitalUser.doc('hospital-user').set({
      'hospital-user': createHospitalUserList()
    });
  }
}
