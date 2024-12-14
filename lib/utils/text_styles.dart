import 'package:flutter/material.dart';

extension DropdownTextStyles on Text {
  Text dropDownTextStyle() {
    return Text(data!,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black));
  }
}
