import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'package:flutter/material.dart';
import 'package:medClientApp/widgets/views/user_profile_display.dart';
class BenefitsDisplay extends StatelessWidget{
  final MyClient client;

  BenefitsDisplay(this.client);
  Map<String,List<Map<String,dynamic>>> get benefitsCollection =>client.allBenefits;
  List<Map<String,dynamic>> get inPatientCollection => benefitsCollection[benefitsCollection.keys.first];
  List<Map<String,dynamic>> get outPatientCollection => benefitsCollection[benefitsCollection.keys.last];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          LineAwesomeIcons.backward,
          color: Colors.white,
        ),
        onPressed: ()=>Navigator.of(context).pop(),),
      body: Container(
        child: ListView(
          children: [
            Heading('Inpatient Benefits'),
            ...inPatientCollection.map((map) => Content('${map.keys.first} : ${map[map.keys.first]}')).toList(),
            Heading('Outpatient Benefits'),
            ...outPatientCollection.map((map) => Content('${map.keys.first} : ${map[map.keys.first]}')).toList()

          ],
        ),
      ),
    );
  }

}