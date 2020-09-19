import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'package:medClientApp/widgets/views/user_profile_display.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../med_client_provider.dart';
class VisitDetails extends StatelessWidget{
  final MyClient client;

  VisitDetails(this.client);
  List<Map<String, String>> get userProfileList =>client.userProfile.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Consumer<GetClientProvider>(
          builder: (context, provider,child) {
            return FlatButton(
              color: Colors.amber,
              onPressed: (){
                provider.changeIsOptionsSelected();
                Navigator.of(context).pop();},
              child: Icon(
                LineAwesomeIcons.backward,
                color: Colors.white,
              ),
            );
          }
      ),
      body: Container(),
    );
  }

}

