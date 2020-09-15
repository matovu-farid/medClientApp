import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'package:medClientApp/widgets/views/hospital_services.dart';
import 'package:medClientApp/widgets/views/user_profile_display.dart';

import 'views/benefits_display.dart';
import 'views/user_history_display.dart';
class ViewOptions extends StatelessWidget {
  final MyClient client;

  ViewOptions(this.client);



  @override
  Widget build(BuildContext context) {
    List<Map<String,String>> options =[
      {'User Info': '/UserInfoDisplay'},
      {'Benefits': '/BenefitsDisplay'},
      {'User History':'/UserHistory'},
      {'Hospital Services':'/HospitalServices'}
    ];
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.7,
      width: MediaQuery.of(context).size.width,
      child: MaterialApp(
        routes: {
          '/': (BuildContext context)=>OptionsScreen(options: options),
          '/UserInfoDisplay':(BuildContext context)=>UserInfoDisplay(client),
          '/BenefitsDisplay':(BuildContext context)=>BenefitsDisplay(client),
          '/UserHistory':(BuildContext context)=>UserHistoryDisplay(client),
          '/HospitalServices':(BuildContext context)=>HospitalServicesDisplay(client)


        },


      ),
    );
  }
}

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({
    Key key,
    @required this.options,
  }) : super(key: key);

  final List<Map> options;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            ...options.map((map) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: ()=>Navigator.of(context).pushNamed('${map[map.keys.first]}'),
                child: ClipOval(
                  child: Container(
                    color: Colors.amber,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(map.keys.first,
                          style: TextStyle(color: Colors.white,
                            fontSize: 18
                          ),
                        ),
                      ),
                    ),),
                ),
              ),
            )).toList()
          ],
        ),
      ),
    );
  }
}
