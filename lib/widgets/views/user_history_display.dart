import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'package:medClientApp/widgets/views/user_profile_display.dart';

import 'package:flutter/material.dart';
class UserHistoryDisplay extends StatelessWidget{
  final MyClient client;

  UserHistoryDisplay(this.client);
  List<Map<String, String>> get userProfileList =>client.userProfile.toList();

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
      body: Center(
        child: Column(
          children: [
            Heading('User Profile'),

            ...userProfileList.map((map) => Center(child: Content('${map.keys.first} : ${map[map.keys.first]}'))).toList()
          ],
        ),
      ),
    );
  }

}

