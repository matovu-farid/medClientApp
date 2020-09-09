import 'package:json_annotation/json_annotation.dart';
part 'client_company_model.g.dart';
@JsonSerializable()
class ClientCompany {
  final String companyName;
  final String location;
   final String iconPath;


  ClientCompany({this.companyName, this.location,this.iconPath});

  factory ClientCompany.fromJson(Map<String, dynamic> json) => _$ClientCompanyFromJson(json);
  Map<String, dynamic> toJson() => _$ClientCompanyToJson(this);


  List<Map<String,String>> get listProperties =>
     [
       {'Company': companyName},
       {'Location': location},


     ];

  @override
  String toString() {
    return 'ClientCompany{companyName: $companyName, location: $location, iconPath: $iconPath}';
  }
}