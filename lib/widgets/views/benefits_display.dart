import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:medClientApp/med_client_provider.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'package:flutter/material.dart';
import 'package:medClientApp/widgets/utilities/go_back.dart';
import 'package:medClientApp/widgets/views/user_profile_display.dart';
import 'package:provider/provider.dart';
class BenefitsDisplay extends StatelessWidget{
  final MyClient client;

  BenefitsDisplay(this.client);
  Map<String, Map<String, dynamic>> get benefitsCollection =>client.allBenefits;
  Map<String,dynamic> get inPatientCollection => benefitsCollection[benefitsCollection.keys.first];
  Map<String,dynamic> get outPatientCollection => benefitsCollection[benefitsCollection.keys.last];


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: ListView(
            children: [
              Heading('Inpatient Benefits'),
//              ...inPatientCollection.map((map) => Content('${map.keys.first} : ${map[map.keys.first]}')).toList(),
              ...inPatientCollection.entries.map((e) => Content('${e.key} : ${e.value}')).toList(),
              Heading('Outpatient Benefits'),
              //...outPatientCollection.map((map) => Content('${map.keys.first} : ${map[map.keys.first]}')).toList()
              ...outPatientCollection.entries.map((e) => Content('${e.key} : ${e.value}')).toList(),
            ],
          ),
        ),
        GoBackButton()
      ],
    );
  }

}