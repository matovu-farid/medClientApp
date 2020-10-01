import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:medClientApp/med_client_provider.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'package:flutter/material.dart';
import 'package:medClientApp/widgets/utilities/go_back.dart';
import 'package:provider/provider.dart';

class UserInfoDisplay extends StatelessWidget{
  final MyClient client;

  UserInfoDisplay(this.client);
  List<Map<String, String>> get userProfileList =>client.userProfile.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Consumer<MedicalClientProvider>(
        builder: (context, provider,child) {
          return GoBackButton();
        }
      ),
      body: Container(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Heading('User Profile'),

            ...userProfileList.map((map) => Center(child: Content('${map.keys.first} : ${map[map.keys.first]}'))).toList()
          ],
        ),
      ),
    );
  }

}







class Heading extends StatelessWidget {
  final String text;

  Heading(this.text);

  @override
  Widget build(BuildContext context) {
    return Card(

      color: Colors.amber,
      child: ListTile(
        dense: true,
        title: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white),

          ),
        ),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}

class Content extends StatelessWidget {
  final String text;
  String position;

  Content(this.text,[this.position='O']);
  Color color(){
    return (position=='O')?Colors.blue[400]:Colors.blue[200];
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Center(child: Text(text,style: TextStyle(fontWeight: FontWeight.bold),)),
      contentPadding: EdgeInsets.zero,
    );
  }
}
