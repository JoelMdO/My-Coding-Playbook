import 'package:flutter/material.dart';
import 'package:playbook/screens/insert.dart';
import 'package:playbook/screens/read.dart';
import 'package:playbook/src/provider/provider.dart';
import 'package:playbook/utils/colors.dart';
import 'package:provider/provider.dart';

class HomePageInitButton extends StatefulWidget {
  final String type;
  const HomePageInitButton({super.key, required this.type});

  @override
  State<HomePageInitButton> createState() => _HomePageInitButtonState();
}

class _HomePageInitButtonState extends State<HomePageInitButton> {
  @override
  Widget build(BuildContext context) {
    ///Buttons are created by 3 types: Go to Insert Page and Insert to redirect to Insert Page
    ///and rest to redirect to Read Page
    final isTextFieldChanged =
        Provider.of<DataBaseProvider>(context).isTextFieldChanged;

    return ElevatedButton(
      onPressed: () {
        widget.type == 'Go to Insert Page' || widget.type == 'Insert'
            ? Navigator.push(context,
                MaterialPageRoute(builder: (context) => const InsertData()))
            : Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Read()));
      },
      style: ElevatedButton.styleFrom(
          backgroundColor:
              isTextFieldChanged ? greenLightColor : greenDarkColor,
          shadowColor: blueShadowColor,
          elevation: 5.0),
      child: Text(
        widget.type,
        style: const TextStyle(color: whiteColor),
      ),
    );
  }
}
