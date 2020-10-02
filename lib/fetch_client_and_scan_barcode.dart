import 'package:flutter/material.dart';
import 'package:medClientApp/retrieve_client.dart';

import 'detect_barcode_widget.dart';

class FetchClientAndScanBarcode extends StatelessWidget {
  const FetchClientAndScanBarcode({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: FlatButton(
                color: Colors.grey[700],
                onPressed: () {
                  OnTap().sink.add(ClientStore().id);
                },
                child: Text(
                  'Fetch Client',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            DetectBarcodeWidget(),
          ],
        ),
      ),
    );
  }
}
