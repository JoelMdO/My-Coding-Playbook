import 'package:flutter/material.dart';
import 'package:play_book/src/provider/provider.dart';
import 'package:provider/provider.dart';

class ClearButton extends StatelessWidget {
  const ClearButton({super.key});
  //
  @override
  Widget build(BuildContext context) {
    //
    return ElevatedButton(
        onPressed: () {
          context.read<DataBaseProvider>().clearController('Subject');
          context.read<DataBaseProvider>().clearController('Code');
          context.read<DataBaseProvider>().clearController('Description');
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 109, 180, 166),
            shadowColor: const Color.fromARGB(255, 7, 36, 86),
            elevation: 5.0),
        child: const Text(
          "Clear",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ));
  }
}
