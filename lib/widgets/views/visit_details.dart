import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'package:medClientApp/widgets/utilities/go_back.dart';
import 'package:medClientApp/widgets/utilities/submit_button.dart';
import 'package:provider/provider.dart';
import 'package:regexpattern/regexpattern.dart';

import '../../med_client_provider.dart';

class VisitDetails extends StatelessWidget {
  final MyClient client;

  VisitDetails(this.client);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<MedicalClientProvider>(builder: (context, provider, child) {
      return Scaffold(
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  ...provider.medicalInfoDetails.entries.map((e) {
                    if (e.key == 'Drugs Prescribed') {
                      return Column(
                        children: [
                          Text(
                            'Fill in  all drugs prescribed and the cost',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Table(
                            children: provider.tableRowList,
                          ),
                          FloatingActionButton(
                            onPressed: provider.addRow,
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
                        isNumeric:true,
                        keyboardType: TextInputType.number,
                        onSaved: (String value) {
                          provider.medicalInfoDetails[e.key] = int.parse(value);
                        },
                        onChanged: (String value) {
                          provider.medicalInfoDetails[e.key] = int.parse(value);
                        },
                      );
                    }
                    //TODO: change output to int
                    return RegInputField(
                      initialValue: e.value.toString(),
                      labelText: e.key,
                      onSaved: (String value) {
                        provider.medicalInfoDetails[e.key] = value;
                      },
                      onChanged: (String value) {
                        provider.medicalInfoDetails[e.key] = value;
                      },
                    );
                  }).toList()
                ],
              ),
              GoBackButton(
                alignment: Alignment.bottomLeft,
              ),
              SubmitButton(
                  alignment: Alignment.bottomRight,
                  onPressed: () {
                    _formKey.currentState.validate();
                    _formKey.currentState.save();
                    provider.checkIfMedicalInfoFilled();
                    print('${provider.medicalInfoDetails}');
                  })
            ],
          ),
        ),
      );
    });
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

  RegInputField(
      {
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
        //autofocus: true,
        keyboardType: keyboardType,
        onSaved: onSaved,
        onChanged: onChanged,
        validator: isOptional
            ? (value) {
          if(!value.isNumeric() && value.isNotEmpty && isNumeric){
            return 'This input should be a contain only numbers although optional';
          }
                return null;
              }
            : (value) {
                //TODO: Fix validation
          if(value.isEmpty){
            return 'This value is required';
          }
          if(isNumeric && !value.isNumeric()){
            return 'The value should only contain numbers';

          }

            return null;

              },
        decoration: InputDecoration(
            border: OutlineInputBorder(gapPadding: 6),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black)),
      ),
    );
  }
}
