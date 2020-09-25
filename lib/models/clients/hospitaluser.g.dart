// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospitaluser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HospitalUser _$HospitalUserFromJson(Map<String, dynamic> json) {
  return HospitalUser()
    ..hospitalName = json['hospitalName'] as String
    ..hospitalLocation = json['hospitalLocation'] as String;
}

Map<String, dynamic> _$HospitalUserToJson(HospitalUser instance) =>
    <String, dynamic>{
      'hospitalName': instance.hospitalName,
      'hospitalLocation': instance.hospitalLocation,
    };
