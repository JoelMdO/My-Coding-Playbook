import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playbook/src/provider/provider.dart';
import 'package:playbook/widgets/buttons/dynamic_buttons/save_in_database.dart';
import 'package:playbook/widgets/buttons/dynamic_buttons/update_database.dart';
import 'package:provider/provider.dart';

void copyToClipboard(String text, BuildContext context) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Copied'),
    ),
  );
}

void swithCases(String type, BuildContext context, bool isCopy, dropdownKey,
    String? text, subType) {
  switch (type) {
    case 'Clear':
      context.read<DataBaseProvider>().clearController('Subject');
      context.read<DataBaseProvider>().clearController('Code');
      context.read<DataBaseProvider>().clearController('Description');
      dropdownKey?.currentState?.resetDropdown();
      Provider.of<DataBaseProvider>(context, listen: false).textField(false);
      break;
    case 'Close':
      Navigator.pop(context);
      Provider.of<DataBaseProvider>(context, listen: false).clearAll();
      break;
    case 'Copy':
      copyToClipboard(text!, context);
      isCopy = true;
      break;
    case 'Edit':
      Provider.of<DataBaseProvider>(context, listen: false)
          .selectFieldToBeEdited(subType, true);
      Provider.of<DataBaseProvider>(context, listen: false).textField(true);
      Provider.of<DataBaseProvider>(context, listen: false)
          .isSaveButtonDisabled(true);
      break;
    case 'Save':
      saveInDatabase(context);
      context.read<DataBaseProvider>().clearController('Subject');
      context.read<DataBaseProvider>().clearController('Code');
      context.read<DataBaseProvider>().clearController('Description');
      dropdownKey?.currentState?.resetDropdown();
      Provider.of<DataBaseProvider>(context, listen: false).textField(false);
      Provider.of<DataBaseProvider>(context, listen: false).dataToBeSearch("");
    case 'Save_After_Editing':
      updateDatabase(context);
      context.read<DataBaseProvider>().clearController('Subject');
      context.read<DataBaseProvider>().clearController('Code');
      context.read<DataBaseProvider>().clearController('Description');
      dropdownKey?.currentState?.resetDropdown();
      Provider.of<DataBaseProvider>(context, listen: false).textField(false);
      Provider.of<DataBaseProvider>(context, listen: false).dataToBeSearch("");
      Navigator.pop(context, true);
    case 'Check':
      Provider.of<DataBaseProvider>(context, listen: false)
          .selectFieldToBeEdited(subType, false);
      Provider.of<DataBaseProvider>(context, listen: false)
          .isSaveButtonDisabled(false);
      break;
  }
}
