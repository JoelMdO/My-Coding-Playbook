import 'package:flutter/material.dart';

class ScreenSize {
  final double screenWidth, screenHeight;

  ScreenSize(BuildContext context)
      : screenWidth = MediaQuery.sizeOf(context).width,
        screenHeight = MediaQuery.sizeOf(context).height;
}
