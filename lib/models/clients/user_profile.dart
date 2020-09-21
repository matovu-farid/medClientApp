import 'package:json_annotation/json_annotation.dart';


import 'client_company_model/client_company_model.dart';
part 'user_profile.g.dart';

enum Gender { Male, Female }



@JsonSerializable()
class UserProfile {
  final ClientCompany company;
  final String occupation;
  final String gender;
  final String dateOfBirth;
  final String bloodType;
  final String email;
  final String address;
  final String name;
  String likability;
  String imagePath;
  dynamic imageWidget;
  final String regDate;
  final String holderStatus;
  final String phoneNumber;

  UserProfile(
      {this.holderStatus,
      this.regDate,
      this.likability = 'Dislike',
      this.name,
      this.company,
      this.phoneNumber,
      this.occupation,
      this.gender,
      this.dateOfBirth,
      this.bloodType,
      this.email,
      this.address});

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);


  @override
  String toString() {
    return 'UserProfile{company: $company, occupation: $occupation, gender: $gender, dateOfBirth: $dateOfBirth, bloodType: $bloodType, email: $email, address: $address, name: $name, likability: $likability, imagePath: $imagePath, imageWidget: $imageWidget, regDate: $regDate, holderStatus: $holderStatus, phoneNumber: $phoneNumber}';
  }

  List<Map<String, String>> toList() {
    return [
      {'name':name},
      {'Registration Date':regDate},
      {'Company': company.companyName},
      {'Occupation': occupation},
      {'Phone number': phoneNumber},
      {'DOB': dateOfBirth},
      {'BloodType': bloodType},
      {'Email': email},
      {'Address': address},
    ];
  }
}
