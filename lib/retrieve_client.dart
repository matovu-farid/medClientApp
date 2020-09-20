import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:local_auth/local_auth.dart';
import 'package:medClientApp/med_client_provider.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'package:medClientApp/widgets/view_options.dart';
import 'package:provider/provider.dart';

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

  final LocalAuthentication auth = LocalAuthentication();

  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: false,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }
  @override
  Widget build(BuildContext context) {
    CollectionReference clients = FirebaseFirestore.instance.collection('clients');
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String fetchedId;

    return ChangeNotifierProvider<GetClientProvider>(
      create: (context)=>GetClientProvider(),
      child: ListView(
        children: [

          Consumer<GetClientProvider>(

            builder: (context, provider,child) {
              if(!provider.isOptionsSelected)
              return SizedBox(
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        color: Colors.amber,
                        onPressed: () {
                        //  await _authenticate();
                          OnTap().sink.add(_editingController.text);
                        },
                      child: Text('Fetch Client',
                        style:  TextStyle(
                          color: Colors.white
                        ),
                      ),),
                    ),

                  ],
                ),
              );
              return SizedBox(
                width: 0,
                height: 0,
              );

            }
          ),

          Stack(
            children: [

              Align(
                alignment: Alignment.center,
                child: FutureBuilder<DocumentSnapshot>(
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
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Consumer<GetClientProvider>(
                      builder: (context, provider,child) {
                        if(provider.isOptionsSelected)
                        return FlatButton(
                          color: Colors.amber,
                          onPressed: (){
                              Navigator.of(context).popAndPushNamed('/');
                            provider.changeIsOptionsSelected();
                            },
                          child: Icon(
                            LineAwesomeIcons.backward,
                            color: Colors.white,
                          ),
                        );
                        return SizedBox(
                          width: 0,
                          height: 0,
                        );
                      }
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class OnTap{
  StreamController<String> controller = StreamController<String>();
  StreamSink<String> get sink => controller.sink;
  Stream<String> get stream => controller.stream;
}