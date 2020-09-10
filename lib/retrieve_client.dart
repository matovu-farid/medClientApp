import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'file:///C:/Users/Sarah/Desktop/medcareInsApp/medClientApp/lib/widgets/views/user_profile_display.dart';
import 'package:medClientApp/widgets/view_options.dart';

//FirebaseFirestore firestore = FirebaseFirestore.instance;

class GetClient extends StatelessWidget {

  String client;

  parseString(String clientJson){
     return json.decode(clientJson);
//     print('$client');
  }
  @override
  Widget build(BuildContext context) {
    CollectionReference clients = FirebaseFirestore.instance.collection('clients');


    return FutureBuilder<DocumentSnapshot>(
      future: clients.doc(
          '045ab9b9-3716-4f1e-a1db-d6307ab117dd'  ).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
           MyClient client= MyClient.fromJson(parseString(data['client']));
          parseString(data['client']);
          return ViewOptions(client);
        }

        return Text("loading");
      },
    );
  }
}
