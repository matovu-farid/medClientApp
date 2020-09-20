import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'package:provider/provider.dart';

import '../../med_client_provider.dart';

class VisitDetails extends StatelessWidget{
  final  MyClient client;

  final medicalInfoDetails = {
    'Nature of illness':'',
    'Diagnosis':'',
    'Consultation Fee':'',
    'Drugs Prescribed':[]
  };
  VisitDetails(this.client);

  @override
  Widget build(BuildContext context) {
   return Container(
     width: MediaQuery.of(context).size.width,
     height: MediaQuery.of(context).size.height,
     child: Column(
       children: [
         ...medicalInfoDetails.entries.map((e) => RegInputField(labelText: e.key,)).toList()
       ],
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

  RegInputField(
      {this.labelText,
        this.onChanged,
        this.description,
        this.isCollapsed,
        this.decoration,
        this.onSaved
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        child: TextFormField(
          onSaved: onSaved,
          onChanged: onChanged,
//          validator: MyValidator(description).validate,
          validator: (value){
            if(value==null)
              return 'This field is required';
            return null;
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(gapPadding: 6),
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}