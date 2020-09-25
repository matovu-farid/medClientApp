import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:medClientApp/med_client_provider.dart';
import 'package:provider/provider.dart';

class GoBackButton extends StatelessWidget {
 final AlignmentGeometry alignment;
 final IconData iconData;
   GoBackButton({
    Key key,
     this.alignment = Alignment.centerLeft,
     this.iconData = LineAwesomeIcons.backward
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MedicalClientProvider>(
      builder: (context, provider,child) {
        return Align(
          alignment: alignment,
          child: FlatButton(
            color: Colors.amber,
            onPressed: () {
              Navigator.of(context).pop();
              provider.changeIsOptionsSelected();

            },
            child: Icon(
              iconData,
              color: Colors.white,
            ),
          ),
        );
      }
    );
  }
}
