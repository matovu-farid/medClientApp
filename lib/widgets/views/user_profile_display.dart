import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:medClientApp/models/clients/history.dart';
import 'package:medClientApp/models/clients/myclient.dart';
import 'package:flutter/material.dart';
class UserInfoDisplay extends StatelessWidget{
  final MyClient client;

  UserInfoDisplay(this.client);
  List<Map<String, String>> get userProfileList =>client.userProfile.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          LineAwesomeIcons.backward,
          color: Colors.white,
        ),
        onPressed: ()=>Navigator.of(context).pop(),),
      body: Container(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Heading('User Profile'),

            ...userProfileList.map((map) => Center(child: Content('${map.keys.first} : ${map[map.keys.first]}'))).toList()
          ],
        ),
      ),
    );
  }

}

class BenefitsDisplay extends StatelessWidget{
  final MyClient client;

  BenefitsDisplay(this.client);
  Map<String,List<Map<String,dynamic>>> get benefitsCollection =>client.allBenefits;
  List<Map<String,dynamic>> get inPatientCollection => benefitsCollection[benefitsCollection.keys.first];
  List<Map<String,dynamic>> get outPatientCollection => benefitsCollection[benefitsCollection.keys.last];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          LineAwesomeIcons.backward,
          color: Colors.white,
        ),
        onPressed: ()=>Navigator.of(context).pop(),),
      body: Container(
        child: ListView(
          children: [
            Heading('Inpatient Benefits'),
            ...inPatientCollection.map((map) => Content('${map.keys.first} : ${map[map.keys.first]}')).toList(),
            Heading('Outpatient Benefits'),
            ...outPatientCollection.map((map) => Content('${map.keys.first} : ${map[map.keys.first]}')).toList()

   ],
        ),
      ),
    );
  }

}

class UserHistoryDisplay extends StatelessWidget{
  final MyClient client;

  UserHistoryDisplay(this.client);
  List<Map<String, String>> get userProfileList =>client.userProfile.toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Heading('User Profile'),

        ...userProfileList.map((map) => Center(child: Content('${map.keys.first} : ${map[map.keys.first]}'))).toList()
      ],
    );
  }

}

class HospitalServicesDisplay extends StatefulWidget{
  final MyClient client;

  HospitalServicesDisplay(this.client);

  @override
  _HospitalServicesDisplayState createState() => _HospitalServicesDisplayState();
}

class _HospitalServicesDisplayState extends State<HospitalServicesDisplay> {
  Map<String,List<Map<String,dynamic>>> get benefitsCollection =>widget.client.allBenefits;

  List<Map<String,dynamic>> get inPatientCollectionFunc =>
      benefitsCollection[benefitsCollection.keys.first]
      .map((benefitsCollection) => {benefitsCollection.keys.first:0,'limit':benefitsCollection[benefitsCollection.keys.first],'isChecked':false})
          .toList()
  ;
  List<Map<String,dynamic>>  inPatientCollection ;
  List<Map<String,dynamic>>  outPatientCollection;
  List<Map<String,dynamic>> get outPatientCollectionFunc => benefitsCollection[benefitsCollection.keys.first]
      .map((benefitsCollection) => {benefitsCollection.keys.first:0,
    'limit':benefitsCollection[benefitsCollection.keys.first],
    'isChecked':false})
      .toList();
  @override
  void initState() {
    super.initState();
    inPatientCollection = inPatientCollectionFunc;
    outPatientCollection = outPatientCollectionFunc;
  }

  final GlobalKey<FormState> formKey =  GlobalKey<FormState>();

  submit(){
    formKey.currentState.validate();
    formKey.currentState.save();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,

      persistentFooterButtons: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: FlatButton(
          color: Colors.amber,
            onPressed: ()=>Navigator.of(context).pop(),
            child: Icon(
              LineAwesomeIcons.backward,
              color: Colors.white,
            ),
        ),
      ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
        color: Colors.amber,
            onPressed: ()=>submit(),
            child: Text('Submit'),
      ),
          ),

      ],


      body: Container(
        child: Form(
          key: formKey,
          child: SizedBox(
            width: 300,
            height: 500,
            child: ListView(
              children: [
                Text('In Patient Hospital Services'),
                ...inPatientCollection.map((benefitMap) => SizedBox(
                  width: 300,
                  child: Wrap(
                    children: [
                      CheckboxListTile(
                        title: Text(benefitMap.keys.first),
                        value: benefitMap['isChecked'],
                        onChanged: (bool value) {

                          setState(() {
                            benefitMap['isChecked']= value;
                          });
                        },
                      ),
                      if (benefitMap['isChecked'])
                        TextBox(
                          limit: benefitMap['limit'],
                          text: 'lim : ${benefitMap['limit']} ',
                          onSaved: (textGot) {
                            benefitMap[benefitMap.keys.first]= textGot;

                            //benefitMap.add({'service': textGot});
                          },
                        ),

                    ],
                  ),
                )).toList(),
                Text('Out Patient Hospital Services'),
                ...outPatientCollection.map((benefitMap) => SizedBox(
                  width: 600,
                  child: Wrap(
                    children: [
                      CheckboxListTile(
                        title: Text(benefitMap.keys.first),
                        value: benefitMap['isChecked'],
                        onChanged: (bool value) {
                          benefitMap['isChecked']= value;
                          setState(() {

                          });
                        },
                      ),
                      if (benefitMap['isChecked'])
                        TextBox(
                          limit: benefitMap['limit'],
                          text: 'lim : ${benefitMap['limit']} ',
                          onSaved: (textGot) {
                            benefitMap[benefitMap.keys.first]= textGot;

                            //benefitMap.add({'service': textGot});
                          },
                        ),

                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class TextBox extends StatelessWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final double fieldHeight;
  final int limit;
  final bool isCollapsed;
  final InputDecoration decoration;
  final FormFieldSetter<String> onSaved;

  TextBox({this.text, this.onChanged, this.fieldHeight, @required this.limit,
    this.isCollapsed, this.decoration, @required this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (text != null)
            Flexible(
              flex: 3,
              child: Text('${text} '),
            ),
          Flexible(
            flex: 7,
            child: Container(
//
              child: TextFormField(
                keyboardType: TextInputType.number,
                onSaved: onSaved,

                onChanged: onChanged,
                validator:FaridValidator(limit).validate,

                decoration: decoration ??
                    InputDecoration(
                      border: OutlineInputBorder(gapPadding: 6),
                      isDense: false,
                      isCollapsed: isCollapsed,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }


}

class FaridValidator{
final int limit;
  FaridValidator(this.limit);

  String validate (value) =>

    (int.parse(value)>limit)? "Value exceed limit" : null;

}

class Heading extends StatelessWidget {
  final String text;

  Heading(this.text);

  @override
  Widget build(BuildContext context) {
    return Card(

      color: Colors.yellow,
      child: ListTile(
        dense: true,
        title: Center(
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
          ),
        ),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}

class Content extends StatelessWidget {
  final String text;
  String position;

  Content(this.text,[this.position='O']);
  Color color(){
    return (position=='O')?Colors.blue[400]:Colors.blue[200];
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Center(child: Text(text,style: TextStyle(fontWeight: FontWeight.bold),)),
      contentPadding: EdgeInsets.zero,
    );
  }
}
