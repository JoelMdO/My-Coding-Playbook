import 'package:flutter/material.dart';
import 'package:play_book/src/provider/provider.dart';
import 'package:provider/provider.dart';

class EditButton extends StatelessWidget {
  const EditButton({super.key});
  //
  @override
  Widget build(BuildContext context) {
    //
    return ElevatedButton(
        onPressed: () {
          Provider.of<DataBaseProvider>(context, listen: false).isEditing(true);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 109, 180, 166),
            shadowColor: const Color.fromARGB(255, 7, 36, 86),
            elevation: 5.0),
        child: const Text(
          "Edit",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ));
  }
}
