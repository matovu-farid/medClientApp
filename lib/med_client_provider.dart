import 'package:flutter/cupertino.dart';
import 'package:medClientApp/models/clients/history.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'package:medClientApp/widgets/views/user_profile_display.dart';

import 'widgets/views/visit_details.dart';

UserHistory makeHistory(MyClient client,MedicalInfo medicalInfo){
  return UserHistory(
    medicalInfo: medicalInfo,
      hospitalLocation: 'Kampala',
      hospitalName: 'AAR',
      patientInfo: PatientInfo(
        //TODO: to be adjusted for beneficiaries
          patientName: client.userProfile.name,
          relationship: 'self',
          medicalCardNo: '000000000',
          gender: client.userProfile.gender,
          dateOfBirth: client.userProfile.dateOfBirth),

      clarification: Clarification(
        doctorsQualification: 'optician',
        doctorsName: 'Farid',
      ));
}

class MedicalClientProvider extends ChangeNotifier{
  //TODO: save the medicalInfo of the client and therefore save their visit history
  //TODO: send the client back to the database and check whether the history is fixed
  MyClient _client;
  bool obscurePassword = true;

String _firebaseId = '';
set firebaseId(String id){
  this._firebaseId=id;
  notifyListeners();
}
String get firebaseId =>_firebaseId;
  MedicalInfo medicalInfo = MedicalInfo(
      drugsPrescribed: {},
      natureOfillness: '' ,
      diagnosis: '',
      condition: '',
      consultationFee: 0,
      hospitalServices: []
  );

  bool isOptionsSelected = false;
  bool isMedicalInfoFilled = false;
  final medicalInfoDetails = {
    'Nature of illness':'',
    'Diagnosis':'',
    'Condition':'',
    'Consultation Fee':'',
    'Drugs Prescribed':{},
    'hospital services': List<Map<String,dynamic>>()
  };
  changeObscurePassword(){
    this.obscurePassword = !obscurePassword;
    notifyListeners();
  }
  List<DrugsRow> drugList = [];
  addToDrugList(){
    drugList.add(DrugsRow(provider: this,));
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
    medicalInfo
      ..natureOfillness= medicalInfoDetails['Nature of illness']
      ..diagnosis= medicalInfoDetails['Diagnosis']
      ..condition= medicalInfoDetails['Condition']
      ..consultationFee = medicalInfoDetails['Consultation Fee']
      ..hospitalServices = medicalInfoDetails['hospital services'];
  }
MyClient clientToSubmit(){
     final UserHistory history= makeHistory(_client, medicalInfo);
     _client.historyList.add(history);
     return _client;

}


}

class DrugsRow extends StatelessWidget {
  final MedicalClientProvider provider;
  Map<String,int> drugMap = {};
  String drugName;
  int drugCost;


  DrugsRow({this.provider});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: RegInputField(
                isOptional: true,
                isCollapsed: false,
                onChanged: (drugName) {
                  this.drugName = drugName;
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: RegInputField(
                isOptional: true,
                isCollapsed: false,
                keyboardType: TextInputType.number,
                onSaved: (cost) {
                  drugMap[drugName] = drugCost;
                  provider.medicalInfo.drugsPrescribed.addEntries([MapEntry(drugName, drugCost)]);
                },
                onChanged: (drugCost){
                  this.drugCost = int.parse(drugCost);
                },
              ),
            )
          ],
        ));
  }
}
