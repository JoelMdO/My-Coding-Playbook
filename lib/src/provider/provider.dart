import 'package:flutter/material.dart';

class DataSection {
  final String section;
  final bool isActive;
  DataSection({required this.section, required this.isActive});
}

class DataBaseProvider with ChangeNotifier {
  String _section = '';
  String _subject = '';
  String _code = '';
  String _description = '';
  String _dataToSearch = '';
  String _changedCode = '';
  String _changedDescription = '';
  bool _isSaveButtonIsDisabled = true;
  bool _dropDownToClear = false;
  bool _isTextFieldChanged = false;
  final bool _isEditButtonClicked = false;
  final Map<String, TextEditingController> textControllers = {
    'Subject': TextEditingController(),
    'Code': TextEditingController(),
    'Description': TextEditingController(),
  };

  DataSection _data = DataSection(section: "code", isActive: false);

  get section => _section;
  get subject => _subject;
  get code => _code;
  get description => _description;
  get dataToSearch => _dataToSearch;
  get changedCode => _changedCode;
  get changedDescription => _changedDescription;
  get isTextFieldChanged => _isTextFieldChanged;
  get isEditButtonClicked => _isEditButtonClicked;
  get isSaveButtonIsDisabled => _isSaveButtonIsDisabled;
  DataSection get data => _data;
  bool get dropDownToClear => _dropDownToClear;

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

  void selectFieldToBeEdited(String newSection, bool newIsActive) {
    _data = DataSection(section: newSection, isActive: newIsActive);
    notifyListeners();
  }

  void editedCode(String editedcode) {
    _changedCode = editedcode;
    notifyListeners();
  }

  void editedDescription(String editeddescription) {
    _changedDescription = editeddescription;
    notifyListeners();
  }

  void isSaveButtonDisabled(bool isSaveButtonIsDisabled) {
    _isSaveButtonIsDisabled = isSaveButtonIsDisabled;
    notifyListeners();
  }

  void textField(bool isTextFieldChanged) {
    _isTextFieldChanged = isTextFieldChanged;
    notifyListeners();
  }

  void clearAll() {
    _section = '';
    _subject = '';
    _code = '';
    _description = '';
    _dataToSearch = '';
    _changedCode = '';
    _changedDescription = '';
    notifyListeners();
  }

  void clearDropDown(bool value) {
    _dropDownToClear = value;
    notifyListeners();
  }
}
