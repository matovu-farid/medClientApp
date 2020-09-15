import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'file:///C:/Users/Sarah/Desktop/medcareInsApp/medClientApp/lib/widgets/views/user_profile_display.dart';
import 'package:medClientApp/widgets/view_options.dart';

//FirebaseFirestore firestore = FirebaseFirestore.instance;

class GetClient extends StatefulWidget {

  //String client;

  @override
  _GetClientState createState() => _GetClientState();
}

class _GetClientState extends State<GetClient> {
  parseString(String clientJson){
     return json.decode(clientJson);
//     print('$client');
  }
  TextEditingController _editingController;
  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text:'045ab9b9-3716-4f1e-a1db-d6307ab117dd');
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference clients = FirebaseFirestore.instance.collection('clients');
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String fetchedId;

    return ListView(
      children: [
        SizedBox(
          width: 300,
          child: Wrap(
            children: [
              TextFormField(
                controller: _editingController,
                decoration: InputDecoration(
                  labelText: 'Enter Id'
                ),
                onChanged: (value){
                  _editingController.text = value;
                },
              ),
              FlatButton(
                color: Colors.amber,
                onPressed: () {
                  OnTap().sink.add(_editingController.text);
              },
              child: Text('Fetch Client',
                style:  TextStyle(
                  color: Colors.white
                ),
              ),)
            ],
          ),
        ),

        FutureBuilder<DocumentSnapshot>(
          future: clients.doc(
              '${_editingController.text}' ).get(),
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

            return LoadingIndicator(
              indicatorType: Indicator.ballPulse,
              color: Colors.amber,
            );
          },
        ),
      ],
    );
  }
}

class OnTap{
  StreamController<String> controller = StreamController<String>();
  StreamSink<String> get sink => controller.sink;
  Stream<String> get stream => controller.stream;
}