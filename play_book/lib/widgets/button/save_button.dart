import 'package:flutter/material.dart';
import 'package:play_book/widgets/button/save_in_database.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});
  //
  @override
  Widget build(BuildContext context) {
    //
    return ElevatedButton(
        onPressed: () {
          saveInDatabase(context);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 7, 118, 96),
            shadowColor: const Color.fromARGB(255, 7, 36, 86),
            elevation: 5.0),
        child: const Text(
          "Save",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ));
  }
}
