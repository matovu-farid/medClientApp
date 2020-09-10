import 'package:flutter/material.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'package:medClientApp/widgets/views/user_profile_display.dart';
class ViewOptions extends StatelessWidget {
  final MyClient client;

  ViewOptions(this.client);



  @override
  Widget build(BuildContext context) {
    List<Map<String,String>> options =[
      {'User Info': '/UserInfoDisplay'},
      {'Benefits': '/BenefitsDisplay'},
      {'User History':'/UserHistory'},
      {'Hospital Services':'/HospitalServices'}
    ];
    return MaterialApp(
      routes: {
        '/': (BuildContext context)=>OptionsScreen(options: options),
        '/UserInfoDisplay':(BuildContext context)=>UserInfoDisplay(client),
        '/BenefitsDisplay':(BuildContext context)=>BenefitsDisplay(client),
        '/UserHistory':(BuildContext context)=>UserHistoryDisplay(client),
        '/HospitalServices':(BuildContext context)=>HospitalServicesDisplay(client),
      },


    );
  }
}

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({
    Key key,
    @required this.options,
  }) : super(key: key);

  final List<Map> options;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          ...options.map((map) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: ()=>Navigator.of(context).pushNamed('${map[map.keys.first]}'),
              child: Container(
                color: Colors.yellow,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(map.keys.first,
                      style: TextStyle(color: Colors.white,
                        fontSize: 18
                      ),
                    ),
                  ),
                ),),
            ),
          )).toList()
        ],
      ),
    );
  }
}
