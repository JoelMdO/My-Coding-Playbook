import 'package:flutter/material.dart';

Future<String?> showAddItemDialog(BuildContext context) async {
  TextEditingController controller = TextEditingController();
  String newDropDownItem = '';

  return await showDialog<String>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            key: Key('AlertDialog Dropdown'),
            title: const Text('Add New Item'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Enter Title',
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Close dialog
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  final newItem = controller.text.trim();
                  if (newItem.isNotEmpty) {
                    newDropDownItem = newItem;
                  }
                  Navigator.pop(context,
                      newDropDownItem.isNotEmpty ? newDropDownItem : null);
                },
                child: const Text('Add'),
              ),
            ],
          );
        },
      );
    },
  );
}
