import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medClientApp/models/clients/history.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'package:medClientApp/widgets/utilities/go_back.dart';
import 'package:medClientApp/widgets/utilities/submit_button.dart';
import 'package:provider/provider.dart';

import '../../med_client_provider.dart';

class VisitDetails extends StatelessWidget {
  final MyClient client;

//  final medicalInfoDetails = {
//    'Nature of illness':'',
//    'Diagnosis':'',
//    'Consultation Fee':'',
//    'Drugs Prescribed':''
//  };
  VisitDetails(this.client);

  final _formKey = GlobalKey<FormState>();
//TODO: add a method to automatically add a table field
  List<TableRow> tableRowList = [TableRow(
    children: [
      TableCell(child: Text('Drugs')),
      TableCell(child: Text('Total Cost'))
    ],
  ),
    TableRow(
      children: [
        TableCell(child: RegInputField(isOptional: true,)),
        TableCell(child: RegInputField(isOptional: true,))
      ],
    )];

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
                      return Table(
                        children: tableRowList,
                      );
                    }

                    if (e.key == 'Consultation Fee') {
                      return RegInputField(
                        initialValue: e.value.toString(),
                        labelText: e.key,
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

  RegInputField(
      {
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
        validator: isOptional? (value)=>null: (value) {
          if (value == null) return 'This field is required';
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
