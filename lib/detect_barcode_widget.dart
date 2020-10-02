import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:flutter/material.dart';

import 'barcode_files/firebase_ml.dart';

class DetectBarcodeWidget extends StatelessWidget {
  const DetectBarcodeWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: FlatButton(
        color: Colors.grey[700],
        onPressed: () async {
          Map map = await BarcodeDetectorMachine().detectBarcodes();
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(map['result'])));

//          showDialog<void>(
//            context: context,
//            barrierDismissible: true,
//            // false = user must tap button, true = tap outside dialog
//            builder: (BuildContext dialogContext) {
//              return AlertBarcode(map: map,dialogContext:dialogContext);
//            },
//          );
        },
        child: Text(
          'Scan Barcode',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class AlertBarcode extends StatelessWidget {
  final BuildContext dialogContext;
  const AlertBarcode({
    Key key,
    @required this.map, this.dialogContext,
  }) : super(key: key);

  final Map map;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('title'),
      content: BarCodeImage(
        params: Code39BarCodeParams(
          map['display value'],
          lineWidth:
              1.0, // width for a single black/white bar (default: 2.0)
          barHeight:
              60, // height for the entire widget (default: 100.0)
          withText:
              true, // Render with text label or not (default: false)
        ),
        onError: (error) {
          // Error handler
          print('error = $error');
        },
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('cancel'),
          onPressed: () {
            Navigator.of(dialogContext).pop(); // Dismiss alert dialog
          },
        ),
      ],
    );
  }
}
