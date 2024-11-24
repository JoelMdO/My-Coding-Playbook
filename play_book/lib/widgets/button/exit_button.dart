import 'dart:io';
import 'package:flutter/material.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          exit(0);
        },
        icon: const Icon(
          Icons.exit_to_app_sharp,
          size: 30,
        ));
  }
}
