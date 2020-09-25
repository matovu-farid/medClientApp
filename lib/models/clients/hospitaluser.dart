import 'package:json_annotation/json_annotation.dart';
part 'hospitaluser.g.dart';

@JsonSerializable()
class HospitalUser{
  String hospitalName;
  String hospitalLocation;

  HospitalUser();

  factory HospitalUser.fromJson(Map<String, dynamic> json) => _$HospitalUserFromJson(json);
  Map<String, dynamic> toJson() => _$HospitalUserToJson(this);
}