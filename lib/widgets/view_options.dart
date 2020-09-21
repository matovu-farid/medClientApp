import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:medClientApp/med_client_provider.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'package:medClientApp/widgets/views/hospital_services.dart';
import 'package:medClientApp/widgets/views/user_profile_display.dart';
import 'package:medClientApp/widgets/views/visit_details.dart';
import 'package:provider/provider.dart';

import 'views/benefits_display.dart';
class ViewOptions extends StatelessWidget {
  final MyClient _client;

  ViewOptions(this._client);



  @override
  Widget build(BuildContext context) {
   Map<String,String> options ={
     'User Info': '/UserInfoDisplay',
     'Benefits': '/BenefitsDisplay',
     'Visit Details':'/VisitDetails',
     'Hospital Services':'/HospitalServices'
   };
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.7,
      width: MediaQuery.of(context).size.width,
      child: MaterialApp(
        routes: {
          '/': (BuildContext context)=>OptionsScreen(options: options),
          '/UserInfoDisplay':(BuildContext context)=>UserInfoDisplay(_client),
          '/BenefitsDisplay':(BuildContext context)=>BenefitsDisplay(_client),
          '/VisitDetails':(BuildContext context)=>VisitDetails(_client),
          '/HospitalServices':(BuildContext context)=>HospitalServicesDisplay(_client),



        },


      ),
    );
  }
}

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({
    Key key,
    @required this.options,
  }) : super(key: key);

  final Map<String,String> options;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: true,
      //resizeToAvoidBottomInset: false,
      body: GridView.count(
        physics: ClampingScrollPhysics(),
        crossAxisCount: 2,
        children: [
          ...options.entries.map((map) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<MedicalClientProvider>(

              builder: (context, provider,child) {

                if(map.key == 'Visit Details' && provider.isMedicalInfoFilled)
                  return GestureDetector(
                    onTap: (){
                      provider.changeIsOptionsSelected();
                      Navigator.of(context).pushNamed('${options[map.key]}');
                    },
                    child: ClipOval(
                      child: Container(
                        color: Colors.green,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(LineAwesomeIcons.check,color: Colors.white,),
                          ),
                        ),),
                    ),
                  );
                return GestureDetector(
                  onTap: (){
                    provider.changeIsOptionsSelected();
                    Navigator.of(context).pushNamed('${options[map.key]}');

                    },
                  child: ClipOval(
                    child: Container(
                      color: Colors.amber,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(map.key,
                            style: TextStyle(color: Colors.white,
                              fontSize: 18
                            ),
                          ),
                        ),
                      ),),
                  ),
                );
              }
            ),
          )).toList()
        ],
      ),
    );
  }
}
