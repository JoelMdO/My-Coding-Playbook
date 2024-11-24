import 'package:flutter/material.dart';
import 'package:play_book/src/models/database_helper.dart';
import 'package:play_book/src/provider/provider.dart';
import 'package:provider/provider.dart';

void saveInDatabase(BuildContext context) {
  //
  DatabaseHelper dataBaseHelper = DatabaseHelper.instance;
  String code = '';
  //
  //Providers update
  final dataBaseProvider =
      Provider.of<DataBaseProvider>(context, listen: false);
  final section = dataBaseProvider.section;
  final subject = dataBaseProvider.subject;
  final changedCode = dataBaseProvider.changedCode;
  if (changedCode == '' || changedCode == null) {
    code = dataBaseProvider.code;
  } else {
    code = changedCode;
  }
  final description = dataBaseProvider.description;
  //
  dataBaseHelper.insertData(section, subject, code, description);
  //
  ScaffoldMessenger.of(context) // access ScaffoldMessenger
      .showSnackBar(const SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Color.fromARGB(255, 125, 186, 3),
          content: Text('Data Saved Correctly')));
  //
}
