// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myclient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyClient _$MyClientFromJson(Map<String, dynamic> json) {
  return MyClient(
    allBenefits: (json['allBenefits'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, (e as List)?.map((e) => e as Map<String, dynamic>)?.toList()),
    ),
    historyList: (json['historyList'] as List)
        ?.map((e) =>
            e == null ? null : UserHistory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    userProfile: json['userProfile'] == null
        ? null
        : UserProfile.fromJson(json['userProfile'] as Map<String, dynamic>),
    isGenerated: json['isGenerated'] as bool,
  )..id = json['id'] as String;
}

Map<String, dynamic> _$MyClientToJson(MyClient instance) => <String, dynamic>{
      'userProfile': instance.userProfile,
      'isGenerated': instance.isGenerated,
      'historyList': instance.historyList,
      'id': instance.id,
      'allBenefits': instance.allBenefits,
    };
