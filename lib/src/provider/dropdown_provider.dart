import 'package:flutter/material.dart';

class DropdownProvider with ChangeNotifier {
  bool _dropDownToClear = false;
  bool get dropDownToClear => _dropDownToClear;

  void clearDropDown(bool value) {
    _dropDownToClear = value;
    notifyListeners();
  }
}
