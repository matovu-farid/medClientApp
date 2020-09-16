import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:medClientApp/retrieve_client.dart';

main(List<String> args){
  runApp(MedClientApp());
}

class MedClientApp extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return MaterialApp(

      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: Scaffold(
      appBar: AppBar(title: Center(child: Text("Medcare Client App")),),
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future:_initialization,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Text('Something went wrong with the database');
          }
          if(snapshot.connectionState==ConnectionState.done){
            return GetClient();
          }
          return LoadingIndicator(
            indicatorType: Indicator.ballPulse,
            color: Colors.amber,
          );
        }
      ),
    ),);
  }

}