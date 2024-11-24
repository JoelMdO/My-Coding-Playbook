import 'package:flutter/material.dart';

class CloseButton extends StatelessWidget {
  const CloseButton({super.key});
  //
  @override
  Widget build(BuildContext context) {
    //
    return ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 109, 180, 166),
            shadowColor: const Color.fromARGB(255, 7, 36, 86),
            elevation: 5.0),
        child: const Text(
          "Close",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ));
  }
}
