import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:medClientApp/barcode_files/firebase_ml.dart';
import 'package:medClientApp/med_client_provider.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'package:medClientApp/widgets/view_options.dart';
import 'package:provider/provider.dart';


class GetClient extends StatelessWidget {

  String scannedBarcode = '';


  parseString(String clientJson) {
    return json.decode(clientJson);
  }

  TextEditingController _editingController;





  @override
  Widget build(BuildContext context) {
    CollectionReference clients = FirebaseFirestore.instance.collection('clients');
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String fetchedId;
    _editingController = TextEditingController(text: '08076c2f-6d18-4c38-9a28-83c2dcf45c36');

     final store = IdStore();
     store.id = _editingController.text;
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
                        controller: _editingController,
                        decoration: InputDecoration(labelText: 'Enter Id'),
                        onChanged: (value) {
                          _editingController.text = value;
                          IdStore idStore = IdStore();
                          idStore.id=value;

                        },
                      ),
                    ),
                    Text(scannedBarcode),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: FlatButton(
                                color: Colors.grey[700],
                                onPressed: () {
                                  //  await _authenticate();
                                  OnTap().sink.add(_editingController.text);
                                },
                                child: Text(
                                  'Fetch Client',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: FlatButton(
                                color: Colors.grey[700],
                                onPressed: () async{

                                 Map map = await BarcodeDetectorMachine().detectBarcodes();

                                 showDialog<void>(
                                   context: context,
                                   barrierDismissible: true,
                                   // false = user must tap button, true = tap outside dialog
                                   builder: (BuildContext dialogContext) {
                                     return AlertDialog(
                                       title: Text('title'),
                                       content:BarCodeImage(
                                         params: Code39BarCodeParams(
                                           map['display value'],
                                           lineWidth: 1.0,                // width for a single black/white bar (default: 2.0)
                                           barHeight: 60,               // height for the entire widget (default: 100.0)
                                           withText: true,                // Render with text label or not (default: false)
                                         ),
                                         onError: (error) {               // Error handler
                                           print('error = $error');
                                         },
                                       ),
                                       actions: <Widget>[
                                         FlatButton(
                                           child: Text('cancel'),
                                           onPressed: () {
                                             Navigator.of(dialogContext)
                                                 .pop(); // Dismiss alert dialog
                                           },
                                         ),
                                       ],
                                     );
                                   },
                                 );
                                },
                                child: Text(
                                  'Scan Barcode',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
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
              future: clients.doc('${_editingController.text}').get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data.data();
                  MyClient client =
                      MyClient.fromJson(parseString(data['client']));
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



 class IdStore{
   String _id = '';
   IdStore._instance();
  static final IdStore _idStore = IdStore._instance();
  factory IdStore(){
    return _idStore;}

    set id(String idGot){
    _id = idGot;
    }
    String get id =>_id;

 }
