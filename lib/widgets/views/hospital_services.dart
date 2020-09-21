import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:medClientApp/med_client_provider.dart';
import 'package:medClientApp/models/clients/history.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'package:medClientApp/widgets/utilities/go_back.dart';
import 'package:medClientApp/widgets/utilities/submit_button.dart';
import 'package:medClientApp/widgets/views/user_profile_display.dart';
import 'package:provider/provider.dart';

//TODO: add hospital Services to the overall medicasl Info of the client
class HospitalServicesDisplay extends StatefulWidget {
  final MyClient client;

  HospitalServicesDisplay(this.client);

  @override
  _HospitalServicesDisplayState createState() =>
      _HospitalServicesDisplayState();
}

class _HospitalServicesDisplayState extends State<HospitalServicesDisplay> {
  Map<String, Map<String, dynamic>> get benefitsCollection =>
      widget.client.allBenefits;

    List<Map<String, dynamic>> get inPatientCollectionFunc =>

  benefitsCollection[benefitsCollection.keys.first].entries.map((e) => {
    e.key: 0,
    'limit': benefitsCollection[e.key],
    'isChecked': false
  }).toList();
  List<Map<String, dynamic>> inPatientCollection;

  List<Map<String, dynamic>> outPatientCollection;

  List<Map<String, dynamic>> get outPatientCollectionFunc =>
      benefitsCollection[benefitsCollection.keys.last].entries.map((e) => {
        e.key: 0,
        'limit': benefitsCollection[e.key],
        'isChecked': false
      }).toList();

  @override
  void initState() {
    super.initState();
    inPatientCollection = inPatientCollectionFunc;
    outPatientCollection = outPatientCollectionFunc;
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  submit() {
    formKey.currentState.validate();
    formKey.currentState.save();
  }

  String hospitalSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Form(
              key: formKey,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 500,
                child: ListView(
                  children: [
                    Heading('In Patient Hospital Services'),
                    ...inPatientCollection
                        .map((benefitMap) => SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Wrap(
                                children: [
                                  CheckboxListTile(
                                    title: Text(benefitMap.keys.first),
                                    value: benefitMap['isChecked'],
                                    onChanged: (bool value) {
                                      setState(() {
                                        benefitMap['isChecked'] = value;
                                      });
                                    },
                                  ),
                                  if (benefitMap['isChecked'])
                                    TextBox(
                                      limit: benefitMap['limit'],
                                      text: 'lim : ${benefitMap['limit']} ',
                                      onSaved: (textGot) {
                                        benefitMap[benefitMap.keys.first] =
                                            textGot;
                                      },
                                    ),
                                ],
                              ),
                            ))
                        .toList(),
                    Heading('Out Patient Hospital Services'),
                    ...outPatientCollection
                        .map((benefitMap) => SizedBox(
                              width: 600,
                              child: Wrap(
                                children: [
                                  CheckboxListTile(
                                    title: Text(benefitMap.keys.first),
                                    value: benefitMap['isChecked'],
                                    onChanged: (bool value) {
                                      benefitMap['isChecked'] = value;
                                      setState(() {});
                                    },
                                  ),
                                  if (benefitMap['isChecked'])
                                    TextBox(
                                      limit: benefitMap['limit'],
                                      text: 'lim : ${benefitMap['limit']} ',
                                      onSaved: (textGot) {
                                        benefitMap[benefitMap.keys.first] =
                                            textGot;

                                        //benefitMap.add({'service': textGot});
                                      },
                                    ),
                                ],
                              ),
                            ))
                        .toList(),
                  ],
                ),
              ),
            ),
          ),
          GoBackButton(),
          SubmitButton(onPressed: submit),
        ],
      ),
    );
  }
}


class MyDropDown extends StatelessWidget {
  final List<String> dropdownNames;
  final String text;
  final bool isCollapsed;
  final String selectedItem;
  final String hint;
  final ValueChanged onChanged;

  MyDropDown(
      {@required this.dropdownNames,
      this.text,
      this.isCollapsed = true,
      @required this.selectedItem,
      this.hint,
      @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropItems = [
      ...dropdownNames.map((name) => DropdownMenuItem<String>(
            value: name,
            child: Text(name),
          )),
    ];
    return Wrap(
//      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (text != null) Heading('${text} : '),
        DropdownButton<String>(
            value: selectedItem, onChanged: onChanged, items: dropItems),
      ],
    );
  }
}

class TextBox extends StatelessWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final double fieldHeight;
  final int limit;
  final bool isCollapsed;
  final InputDecoration decoration;
  final FormFieldSetter<String> onSaved;

  TextBox(
      {this.text,
      this.onChanged,
      this.fieldHeight,
      @required this.limit,
      this.isCollapsed,
      this.decoration,
      @required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (text != null)
            Flexible(
              flex: 3,
              child: Text('${text} '),
            ),
          Flexible(
            flex: 7,
            child: Container(
//
              child: TextFormField(
                keyboardType: TextInputType.number,
                onSaved: onSaved,
                onChanged: onChanged,
                validator: FaridValidator(limit).validate,
                decoration: decoration ??
                    InputDecoration(
                      border: OutlineInputBorder(gapPadding: 6),
                      isDense: false,
                      isCollapsed: isCollapsed,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FaridValidator {
  final int limit;

  FaridValidator(this.limit);

  String validate(value) =>
      (int.parse(value) > limit) ? "Value exceed limit" : null;
}
