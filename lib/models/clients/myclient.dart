

import 'package:json_annotation/json_annotation.dart';
import 'package:medClientApp/models/clients/history.dart';
import 'package:medClientApp/models/clients/user_profile.dart';
import 'package:uuid/uuid.dart';

part 'myclient.g.dart';

@JsonSerializable()
class MyClient {
  final UserProfile userProfile;
  final bool isGenerated;
  List<UserHistory> historyList;
  String id;

  final Map<String, List<Map<String, dynamic>>> allBenefits;

  MyClient(
      {this.allBenefits,
      this.historyList,
      this.userProfile,
      this.isGenerated = true,
      })
  :id = Uuid().v4()
  ;
  factory MyClient.fromJson(Map<String, dynamic> json) => _$MyClientFromJson(json);
  Map<String, dynamic> toJson() => _$MyClientToJson(this);

  @override
  String toString() {
    return 'MyClient{historyList: $historyList, userProfile: $userProfile, isGenerated: $isGenerated, id: $id, allBenefits: $allBenefits}';
  }
}
