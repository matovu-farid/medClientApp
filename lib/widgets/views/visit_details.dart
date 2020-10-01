import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'package:medClientApp/widgets/utilities/go_back.dart';
import 'package:medClientApp/widgets/utilities/submit_button.dart';
import 'package:provider/provider.dart';
import 'package:regexpattern/regexpattern.dart';

import '../../med_client_provider.dart';

class VisitDetails extends StatefulWidget {
  final MyClient client;
  final MedicalClientProvider provider;

  VisitDetails(this.client, this.provider);

  @override
  _VisitDetailsState createState() => _VisitDetailsState();
}

class _VisitDetailsState extends State<VisitDetails> {
  final _formKey = GlobalKey<FormState>();

  void goToHospitalServices() {
    _formKey.currentState.validate();
    _formKey.currentState.save();
    widget.provider.checkIfMedicalInfoFilled();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              children: [

                ...widget.provider.medicalInfoDetails.entries.where((value) => value.key !='hospital services').map((e) {
                  if (e.key == 'Drugs Prescribed') {
                    return Column(
                      children: [
                        Text(
                          'Fill in  all drugs prescribed and the cost',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        ...widget.provider.drugList,
                        FloatingActionButton(
                          onPressed: widget.provider.addToDrugList,
                          backgroundColor: Colors.green,
                          child: Icon(
                            LineAwesomeIcons.plus,
                            color: Colors.white,
                          ),
                        )
                      ],
                    );
                  }

                  if (e.key == 'Consultation Fee') {
                    return RegInputField(
                      initialValue: e.value.toString(),
                      labelText: e.key,
                      isNumeric: true,
                      keyboardType: TextInputType.number,
                      onSaved: (String value) {
                        widget.provider.medicalInfoDetails[e.key] = int.parse(value);
                      },
                      onChanged: (String value) {
                        widget.provider.medicalInfoDetails[e.key] = int.parse(value);
                      },
                    );
                  }
                  //TODO: change output to int
                  return RegInputField(
                    initialValue: (e.value.toString()=='')?'':e.value.toString(),
                    labelText: e.key,
                    onSaved: (String value) {
                      widget.provider.medicalInfoDetails[e.key] = value;
                    },
                    onChanged: (String value) {
                      widget.provider.medicalInfoDetails[e.key] = value;
                    },
                  );
                }).toList(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                )
              ],
            ),
            GoBackButton(
              alignment: Alignment.bottomLeft,
            ),
            GoToHospitalServices(
                alignment: Alignment.bottomRight,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    Navigator.of(context).pushNamed('/HospitalServices');
                  }
//                  provider.checkIfMedicalInfoFilled();
                })
          ],
        ),
      ),
    );
  }
}

class RegInputField extends StatelessWidget {
  final String labelText;
  final ValueChanged<String> onChanged;
  final String description;
  final bool isCollapsed;
  final InputDecoration decoration;
  final FormFieldSetter<String> onSaved;
  final String initialValue;
  final TextInputType keyboardType;
  final bool isOptional;
  final bool isNumeric;
  final bool obscureText;
  final Widget trailing;

  RegInputField(
      {
        this.trailing = const SizedBox(width: 0,height: 0,),
        this.obscureText = false,
        this.isNumeric = false,
      this.isOptional = false,
      this.labelText,
      this.onChanged,
      this.description,
      this.isCollapsed = false,
      this.decoration,
      this.onSaved,
      this.initialValue = '',
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onSaved: onSaved,
        onChanged: onChanged,
        validator: isOptional
            ? (value) {
                if (!value.isNumeric() && value.isNotEmpty && isNumeric) {
                  return 'This input should be a contain only numbers although optional';
                }
                return null;
              }
            : (value) {
                //TODO: Fix validation
                if (value.isEmpty) {
                  return 'This value is required';
                }
                if (isNumeric && !value.isNumeric()) {
                  return 'The value should only contain numbers';
                }

                return null;
              },
        decoration: InputDecoration(
          suffixIcon: trailing,
            border: OutlineInputBorder(gapPadding: 6),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black)),
      ),
    );
  }
}


