import 'package:flutter/cupertino.dart';
import 'package:medClientApp/models/clients/history.dart';
import 'package:medClientApp/models/clients/myclient.dart';

class MedicalClientProvider extends ChangeNotifier{
  //TODO: save the medicalInfo of the client and theerefore save their visit history
  //TODO: send the client back to the database and check whether the history is fixed
  MyClient _client;
  final medicalInfoDetails = {
    'Nature of illness':'',
    'Diagnosis':'',
    'Condition':'',
    'Consultation Fee':'',
    'Drugs Prescribed':{}
  };
  MedicalInfo medicalInfo;
  bool isOptionsSelected = false;
  bool isMedicalInfoFilled = false;
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
     List<Map<String,String>> listOfEmpties = medicalInfoDetails.entries.where((element) => element.value=='').map((e) => {e.key:e.value}).toList();
     isMedicalInfoFilled =  listOfEmpties.length>0?false:true;
     notifyListeners();

  }

}