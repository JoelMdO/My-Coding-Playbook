import 'package:flutter/material.dart';
import 'package:playbook/widgets/textfield/data_insert.dart';

class AddDropDownButton extends StatefulWidget {
  const AddDropDownButton({super.key});

  @override
  State<AddDropDownButton> createState() => _AddDropDownButtonState();
}

class _AddDropDownButtonState extends State<AddDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        const DataInsertField(type: "dropDown");
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 7, 118, 96),
          shadowColor: const Color.fromARGB(255, 7, 36, 86),
          elevation: 5.0),
      child: const Text(
        "+",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
