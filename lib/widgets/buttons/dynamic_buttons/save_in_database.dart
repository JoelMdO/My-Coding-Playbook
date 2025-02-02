import 'package:flutter/material.dart';
import 'package:playbook/src/models/database_helper.dart';
import 'package:playbook/src/provider/provider.dart';
import 'package:playbook/utils/colors.dart';
import 'package:provider/provider.dart';

void saveInDatabase(BuildContext context) async {
  //
  DatabaseHelper dataBaseHelper = DatabaseHelper.instance;
  String responseText;
  //
  //Providers update
  final dataBaseProvider =
      Provider.of<DataBaseProvider>(context, listen: false);
  final section = dataBaseProvider.dataToSearch;
  final subject = dataBaseProvider.subject;
  final code = dataBaseProvider.code;
  final description = dataBaseProvider.description;

  /// Access ScaffoldMessenger in advance due to async operation to allow showing SnackBar depending of the response
  final messenger = ScaffoldMessenger.of(context);

  ///Save the data in the sqlite
  final response =
      await dataBaseHelper.insertData(section, subject, code, description);

  ///Retrive an answer to check if the data has been saved

  if (response > 0) {
    responseText = 'Data Saved Correctly';
  } else {
    responseText = 'Data Not Saved';
  }

  // Ensure the widget is still mounted before showing SnackBar
  messenger // access ScaffoldMessenger
      .showSnackBar(SnackBar(
          duration: const Duration(seconds: 3),
          backgroundColor: greenColor,
          content: Text(responseText)));

  //
}
