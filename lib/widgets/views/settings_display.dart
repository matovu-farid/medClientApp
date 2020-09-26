import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:medClientApp/med_client_provider.dart';
import 'package:medClientApp/models/clients/hospitaluser.dart';
import 'package:lipsum/lipsum.dart' as lipsum;
import 'package:medClientApp/widgets/utilities/go_back.dart';
import 'package:medClientApp/widgets/views/user_profile_display.dart';
import 'package:medClientApp/widgets/views/visit_details.dart';
import 'package:provider/provider.dart';

class SettingsDisplay extends StatelessWidget{
   final hospitalUser=
   HospitalUser()
   ..hospitalName = lipsum.createWord()
   ..hospitalLocation = lipsum.createWord()
   ..password = lipsum.createWord()
   ;

  @override
  Widget build(BuildContext context) {
    SendHospitalUser().sendToFireBase();
    return Stack(
      children: [
        Scaffold(
          body: ListView(
            children: [
              Heading('Hospital Name'),
              RegInputField(
                initialValue: '${hospitalUser.hospitalName}',
              ),
              Heading('Password'),
              Consumer<MedicalClientProvider>(
                builder: (context, provider,child) {
                  return RegInputField(
                    obscureText: provider.obscurePassword,
                      trailing: IconButton(
                        icon: Icon(LineAwesomeIcons.eye),
                        onPressed: (){
                          provider.changeObscurePassword();
                        },
                      ),
                      initialValue:'${hospitalUser.password}');
                }
              ),
              //Text('${hospitalUser.hospitalName}'),

            ],
          ),
        ),
        GoBackButton(
          alignment: Alignment.bottomLeft,
        )
      ],
    );
  }

}