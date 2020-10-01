import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:medClientApp/retrieve_client.dart';

import 'models/clients/hospitaluser.dart';

main(List<String> args) {
  runApp(MedClientApp());
}

class MedClientApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.grey[900],
      ),
      home: Scaffold(
        //resizeToAvoidBottomPadding: true,
        resizeToAvoidBottomInset: true,

        appBar: AppBar(
          title: Center(child: Text("Medcare Client App")),
        ),

        body: FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong with the database');
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return GetClient();
              }
              return LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                color: Colors.amber,
              );
            }),
      ),
    );
  }
}
