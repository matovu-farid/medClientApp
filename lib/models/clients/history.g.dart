// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserHistory _$UserHistoryFromJson(Map<String, dynamic> json) {
  return UserHistory(
    hospitalLocation: json['hospitalLocation'] as String,
    hospitalName: json['hospitalName'] as String,
    patientInfo: json['patientInfo'] == null
        ? null
        : PatientInfo.fromJson(json['patientInfo'] as Map<String, dynamic>),
    medicalInfo: json['medicalInfo'] == null
        ? null
        : MedicalInfo.fromJson(json['medicalInfo'] as Map<String, dynamic>),
    clarification: json['clarification'] == null
        ? null
        : Clarification.fromJson(json['clarification'] as Map<String, dynamic>),
    iconPath: json['iconPath'] as String,
  )
    ..date = json['date'] as String
    ..sum = json['sum'] as String;
}

Map<String, dynamic> _$UserHistoryToJson(UserHistory instance) =>
    <String, dynamic>{
      'patientInfo': instance.patientInfo,
      'medicalInfo': instance.medicalInfo,
      'clarification': instance.clarification,
      'iconPath': instance.iconPath,
      'hospitalName': instance.hospitalName,
      'hospitalLocation': instance.hospitalLocation,
      'date': instance.date,
      'sum': instance.sum,
    };

MedicalInfo _$MedicalInfoFromJson(Map<String, dynamic> json) {
  return MedicalInfo(
    drugsPrescribed: (json['drugsPrescribed'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as int),
    ),
    natureOfillness: json['natureOfillness'] as String,
    diagnosis: json['diagnosis'] as String,
    condition: json['condition'] as String,
    consultationFee: json['consultationFee'] as int,
    hospitalServices: (json['hospitalServices'] as List)
        ?.map((e) => e as Map<String, dynamic>)
        ?.toList(),
  );
}

Map<String, dynamic> _$MedicalInfoToJson(MedicalInfo instance) =>
    <String, dynamic>{
      'natureOfillness': instance.natureOfillness,
      'diagnosis': instance.diagnosis,
      'condition': instance.condition,
      'consultationFee': instance.consultationFee,
      'hospitalServices': instance.hospitalServices,
      'drugsPrescribed': instance.drugsPrescribed,
    };

Clarification _$ClarificationFromJson(Map<String, dynamic> json) {
  return Clarification(
    doctorsName: json['doctorsName'] as String,
    doctorsQualification: json['doctorsQualification'] as String,
  );
}

Map<String, dynamic> _$ClarificationToJson(Clarification instance) =>
    <String, dynamic>{
      'doctorsName': instance.doctorsName,
      'doctorsQualification': instance.doctorsQualification,
    };

PatientInfo _$PatientInfoFromJson(Map<String, dynamic> json) {
  return PatientInfo(
    patientName: json['patientName'] as String,
    relationship: json['relationship'] as String,
    medicalCardNo: json['medicalCardNo'] as String,
    gender: json['gender'] as String,
    dateOfBirth: json['dateOfBirth'] as String,
  );
}

Map<String, dynamic> _$PatientInfoToJson(PatientInfo instance) =>
    <String, dynamic>{
      'patientName': instance.patientName,
      'relationship': instance.relationship,
      'medicalCardNo': instance.medicalCardNo,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth,
    };
