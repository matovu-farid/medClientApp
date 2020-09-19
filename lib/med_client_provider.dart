import 'package:flutter/cupertino.dart';

class GetClientProvider extends ChangeNotifier{
  bool isOptionsSelected = false;

  changeIsOptionsSelected(){
    isOptionsSelected = !isOptionsSelected;
    notifyListeners();
  }

}