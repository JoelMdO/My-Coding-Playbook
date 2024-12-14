import 'package:flutter/material.dart';
import 'package:playbook/src/provider/provider.dart';
import 'package:provider/provider.dart';

void updateProviders(BuildContext context, subject, code, description) {
  Provider.of<DataBaseProvider>(context, listen: false).insertSubject(subject!);
  Provider.of<DataBaseProvider>(context, listen: false).insertCode(code!);
  Provider.of<DataBaseProvider>(context, listen: false)
      .insertDescription(description!);
}
