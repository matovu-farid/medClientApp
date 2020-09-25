import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
part 'history.g.dart';



@JsonSerializable()
class UserHistory {
  final PatientInfo patientInfo;
   MedicalInfo medicalInfo;
  final Clarification clarification;
  final String iconPath;
  final String hospitalName;
  final String hospitalLocation;
  String date;
  String sum;

  UserHistory(
      {
        @required this.hospitalLocation,
        @required this.hospitalName,
        @required this.patientInfo,
        @required this.medicalInfo,
        @required this.clarification,
        this.iconPath})
      :

        this.sum = "${medicalInfo.hospitalServices.last['sum']},000";

  factory UserHistory.fromJson(Map<String, dynamic> json) => _$UserHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$UserHistoryToJson(this);

  @override
  String toString() {
    return 'History{patientInfo: $patientInfo, medicalInfo: $medicalInfo, clarification: $clarification}';
  }
}

@JsonSerializable()
class MedicalInfo {
   String natureOfillness;
   String diagnosis;
   String condition;
   int consultationFee;
  List<Map<String,dynamic>> hospitalServices;
  //final List<Map<String, String>> results;
   Map<String,int> drugsPrescribed;

  MedicalInfo(
      {this.drugsPrescribed,
        this.natureOfillness,
        this.diagnosis,
        this.condition,
        this.consultationFee,
        this.hospitalServices,
        //this.results
      });
  factory MedicalInfo.fromJson(Map<String, dynamic> json) => _$MedicalInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MedicalInfoToJson(this);

  @override
  String toString() {
    return 'MedicalInfo{natureOfillness: $natureOfillness, diagnosis: $diagnosis, condition: $condition, consultationFee: $consultationFee, hospitalServices: $hospitalServices, drugsPrescribed: $drugsPrescribed}';
  }
}

@JsonSerializable()
class Clarification {
  final String doctorsName;
  final String doctorsQualification;

  Clarification({this.doctorsName, this.doctorsQualification});

  factory Clarification.fromJson(Map<String, dynamic> json) => _$ClarificationFromJson(json);
  Map<String, dynamic> toJson() => _$ClarificationToJson(this);

  @override
  String toString() {
    return 'Clarification{doctorsName: $doctorsName, doctorsQualification: $doctorsQualification}';
  }

  List<Map<String, String>> toList() {
    return [
      {'Doctor\'s Name': doctorsName},
      {'Doctor\'s Qualification': doctorsQualification}
    ];
  }
}

@JsonSerializable()
class PatientInfo {
  final String patientName;
  final String relationship;
  final String medicalCardNo;
  final String gender;
  final String dateOfBirth;

  PatientInfo(
      {this.patientName,
        this.relationship,
        this.medicalCardNo,
        this.gender,
        this.dateOfBirth});
  factory PatientInfo.fromJson(Map<String, dynamic> json) => _$PatientInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PatientInfoToJson(this);

  @override
  String toString() {
    return 'patientName: $patientName\n relationship: $relationship\n medicalCardNo: $medicalCardNo\n gender: $gender\n dateOfBirth: $dateOfBirth';
  }

  List<Map<String, String>> toList() {
    return [
      {'Patient Name ': patientName},
      {'Relationship ': relationship},
      {'Medical CardNo ': medicalCardNo},
      {'Gender ': gender},
      {'DOB ': dateOfBirth}
    ];
  }
}
