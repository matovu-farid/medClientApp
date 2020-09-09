// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientCompany _$ClientCompanyFromJson(Map<String, dynamic> json) {
  return ClientCompany(
    companyName: json['companyName'] as String,
    location: json['location'] as String,
    iconPath: json['iconPath'] as String,
  );
}

Map<String, dynamic> _$ClientCompanyToJson(ClientCompany instance) =>
    <String, dynamic>{
      'companyName': instance.companyName,
      'location': instance.location,
      'iconPath': instance.iconPath,
    };
