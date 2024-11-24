import 'package:flutter/material.dart';
import 'package:play_book/screens/insert.dart';
import 'package:play_book/screens/read.dart';

class InitButton extends StatefulWidget {
  final String type;
  const InitButton({super.key, required this.type});

  @override
  State<InitButton> createState() => _InitButtonState();
}

class _InitButtonState extends State<InitButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (widget.type == 'Insert') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const InsertData()));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Read()));
        }
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 7, 118, 96),
          shadowColor: const Color.fromARGB(255, 7, 36, 86),
          elevation: 5.0),
      child: Text(
        widget.type,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
