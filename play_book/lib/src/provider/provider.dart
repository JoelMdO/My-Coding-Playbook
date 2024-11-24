import 'package:flutter/material.dart';

class DataBaseProvider with ChangeNotifier {
  String _section = '';
  String _subject = '';
  String _code = '';
  String _description = '';
  String _dataToSearch = '';
  String _changedCode = '';
  bool _isEdit = false;

  final Map<String, TextEditingController> textControllers = {
    'Subject': TextEditingController(),
    'Code': TextEditingController(),
    'Description': TextEditingController(),
  };
  get section => _section;
  get subject => _subject;
  get code => _code;
  get description => _description;
  get dataToSearch => _dataToSearch;
  get isEdit => _isEdit;
  get changedCode => _changedCode;

  void selectSection(String section) {
    _section = section;

    notifyListeners();
  }

  void insertSubject(String subject) {
    _subject = subject;

    notifyListeners();
  }

  void insertCode(String code) {
    _code = code;
    notifyListeners();
  }

  void insertDescription(String description) {
    _description = description;

    notifyListeners();
  }

  void dataToBeSearch(String data) {
    _dataToSearch = data;

    notifyListeners();
  }

  void clearController(String type) {
    textControllers[type]?.clear();
    notifyListeners();
  }

  void isEditing(bool isEdit) {
    _isEdit = isEdit;
    notifyListeners();
  }

  void editedCode(String Code) {
    _changedCode = code;
    notifyListeners();
  }
}
