import 'package:flutter/material.dart';
import 'package:playbook/src/provider/provider.dart';
import 'package:provider/provider.dart';

void updateProvidersonTextField(
    BuildContext context, String section, String value) {
  final provider = Provider.of<DataBaseProvider>(context, listen: false);
  provider.textField(true);
  provider.isSaveButtonDisabled(false);
  if (value.isEmpty || value == '') {
    provider.textField(false);
    provider.isSaveButtonDisabled(true);
  }
  if (section == 'Subject') {
    provider.insertSubject(value);
    provider.textControllers['Subject']?.text = value;
  } else if (section == 'Code') {
    provider.insertCode(value);
    provider.textControllers['Code']?.text = value;
  } else if (section == 'Description') {
    provider.insertDescription(value);
    provider.textControllers['Description']?.text = value;
  }
}
