import 'package:flutter/material.dart';
import 'package:playbook/src/models/database_helper.dart';
import 'package:playbook/src/provider/provider.dart';
import 'package:playbook/widgets/dialog/dropdown_dialog.dart';
import 'package:provider/provider.dart';

Future<String> addItemToDropdown(
    BuildContext context, StateSetter setState) async {
  DatabaseHelper db = DatabaseHelper.instance;
  final provider = Provider.of<DataBaseProvider>(context, listen: false);
  final newAddedItem = await showAddItemDialog(context);

  if (newAddedItem != null && newAddedItem.isNotEmpty) {
    final row = await db.insertNewDropdownItem(newAddedItem);
    if (row != 0) {
      provider.dataToBeSearch(newAddedItem);
    }
    return newAddedItem;
  }
  return "";
}
