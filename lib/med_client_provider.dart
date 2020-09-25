import 'package:flutter/cupertino.dart';
import 'package:medClientApp/models/clients/history.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'package:medClientApp/widgets/views/user_profile_display.dart';

import 'widgets/views/visit_details.dart';

class MedicalClientProvider extends ChangeNotifier{
  //TODO: save the medicalInfo of the client and theerefore save their visit history
  //TODO: send the client back to the database and check whether the history is fixed
  MyClient _client;
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

  UserHistory history = UserHistory(
      hospitalLocation: null,
      hospitalName: null,
      patientInfo: null,
      //medicalInfo: null,
      clarification: null);

  //should only be set after checking that the parameters are set
  setMedicalInfo (){

    medicalInfo
      ..natureOfillness= medicalInfoDetails['Nature of illness']
      ..diagnosis= medicalInfoDetails['Diagnosis']
      ..condition= medicalInfoDetails['Condition']
      ..consultationFee = medicalInfoDetails['Consultation Fee']
      ..hospitalServices = medicalInfoDetails['hospital services'];
    history.medicalInfo=medicalInfo;

  print('$medicalInfo');



  }
  checkIfMedicalInfoFilled(){
    //TODO: FIX THIS
   //  List<Map<String,String>> listOfEmpties = medicalInfoDetails.entries.where((element) => element.value=='').map((e) => {e.key:e.value}).toList();
    // isMedicalInfoFilled =  listOfEmpties.length>0?false:true;
     notifyListeners();

  }

}

//class DrugCollection{
//  List<DrugsRow> drugList = [];
//
//}

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
                // onSaved: (drugName) {},
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
//                  var drugsPrescribed= provider.medicalInfoDetails['Drugs Prescribed'];
                  provider.medicalInfo.drugsPrescribed.addEntries([MapEntry(drugName, drugCost)]);
//                  drugsPrescribed.addEntries([MapEntry(drugName, drugCost)]);

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
