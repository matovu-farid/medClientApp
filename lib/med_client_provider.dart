import 'package:flutter/cupertino.dart';
import 'package:medClientApp/models/clients/history.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'package:medClientApp/widgets/views/user_profile_display.dart';

import 'widgets/views/visit_details.dart';

class MedicalClientProvider extends ChangeNotifier{
  //TODO: save the medicalInfo of the client and theerefore save their visit history
  //TODO: send the client back to the database and check whether the history is fixed
  MyClient _client;
  MedicalInfo medicalInfo;
  bool isOptionsSelected = false;
  bool isMedicalInfoFilled = false;
  final medicalInfoDetails = {
    'Nature of illness':'',
    'Diagnosis':'',
    'Condition':'',
    'Consultation Fee':'',
    'Drugs Prescribed':{}
  };
  List<TableRow> tableRowList = [
    TableRow(
    children: [
      TableCell(child: Heading('Drugs')),
      TableCell(child: Heading('Total Cost'))
    ],
  ),
    TableRow(
      children: [
        TableCell(child: RegInputField(isOptional: true,)),
        TableCell(child: RegInputField(isOptional: true,
          keyboardType: TextInputType.number,))
      ],
    )];
  void addRow(){
    this.tableRowList.add(TableRow(
      children: [
        TableCell(child: RegInputField(isOptional: true,)),
        TableCell(child: RegInputField(isOptional: true,keyboardType: TextInputType.number))
      ],
    ));
    notifyListeners();
  }


set client(MyClient client){
  this._client = client;
}
MyClient get client =>_client;
  changeIsOptionsSelected(){
    isOptionsSelected = !isOptionsSelected;
    notifyListeners();
  }

  //should only be set after checking that the parameters are set
  setMedicalInfo (){
  medicalInfo = MedicalInfo(
      drugsPrescribed: medicalInfoDetails['Drugs Prescribed'],
      natureOfillness: medicalInfoDetails['Nature of illness'] ,
      diagnosis: medicalInfoDetails['Diagnosis'],
      condition: medicalInfoDetails['Condition'],
      consultationFee: medicalInfoDetails['Consultation Fee'],
      hospitalServices: null);

  }
  checkIfMedicalInfoFilled(){
    //TODO: FIX THIS
   //  List<Map<String,String>> listOfEmpties = medicalInfoDetails.entries.where((element) => element.value=='').map((e) => {e.key:e.value}).toList();
    // isMedicalInfoFilled =  listOfEmpties.length>0?false:true;
     notifyListeners();

  }

}