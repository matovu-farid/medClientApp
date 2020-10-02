import 'dart:async';
import 'package:medClientApp/fetch_client_and_scan_barcode.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:medClientApp/med_client_provider.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'package:medClientApp/widgets/view_options.dart';
import 'package:provider/provider.dart';

class GetClient extends StatelessWidget {
  parseString(String clientJson) {
    return json.decode(clientJson);
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference clients =
        FirebaseFirestore.instance.collection('clients');
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String fetchedId;

    //final store = ClientStore();
    //store.id = _editingController.text;

    return ChangeNotifierProvider<MedicalClientProvider>(
      create: (context) => MedicalClientProvider(),
      child: ListView(
        children: [
          Consumer<MedicalClientProvider>(builder: (context, provider, child) {
            if (!provider.isOptionsSelected)
              return SizedBox(
                width: 300,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        initialValue: ClientStore().id,
                        decoration: InputDecoration(labelText: 'Enter Id'),
                        onChanged: (value) {
                          ClientStore idStore = ClientStore();
                          idStore.id = value;
                        },
                      ),
                    ),
                    FetchClientAndScanBarcode(),
                  ],
                ),
              );
            return SizedBox(
              width: 0,
              height: 0,
            );
          }),
          Align(
            alignment: Alignment.center,
            child: FutureBuilder<DocumentSnapshot>(
              future: clients.doc('${ClientStore().id}').get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Connect to the internet");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data.data();
                  MyClient client =
                      MyClient.fromJson(parseString(data['client']));
                  parseString(data['client']);
                  ClientStore().client = client;
                  return ViewOptions(client);
                }

                return LoadingIndicator(
                  indicatorType: Indicator.ballPulse,
                  color: Colors.blueGrey[800],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OnTap {
  StreamController<String> controller = StreamController<String>();

  StreamSink<String> get sink => controller.sink;

  Stream<String> get stream => controller.stream;
}

class ClientStore {
  String _id = '08076c2f-6d18-4c38-9a28-83c2dcf45c36';
  MyClient _client;
  ClientStore._instance();
  static final ClientStore _idStore = ClientStore._instance();
  factory ClientStore() {
    return _idStore;
  }

  set id(String idGot) {
    _id = idGot;
  }

  set client(MyClient myclient) {
    _client = myclient;
  }

  MyClient get client => _client;
  String get id => _id;
}
