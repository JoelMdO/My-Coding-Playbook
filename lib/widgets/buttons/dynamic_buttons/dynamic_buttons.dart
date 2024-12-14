import 'package:flutter/material.dart';
import 'package:playbook/utils/colors.dart';
import 'package:playbook/widgets/buttons/dynamic_buttons/services/swith_cases.dart';
import 'package:playbook/widgets/dropdown/dropdown.dart';

class DynamicActionButton extends StatefulWidget {
  final String type;
  final String? text;
  final GlobalKey<DropdownSectionState>? dropdownKey;
  final String? subType;
  const DynamicActionButton({
    super.key,
    required this.type,
    this.text,
    this.dropdownKey,
    this.subType,
  });

  @override
  State<DynamicActionButton> createState() => _DynamicActionButtonState();
}

class _DynamicActionButtonState extends State<DynamicActionButton> {
  //
  /// 4 types of buttons are created: Copy, Edit, Editing and Save
  bool isTheCopyButton = false,
      isTheEditButton = false,
      isTheCheckEditingButton = false,
      isTheSaveAfterEditingButton = false,
      isTheSaveButton = false,
      isbuttonDisabled = false;

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case 'Copy':
        isTheCopyButton = true;
        break;
      case 'Edit':
        isTheEditButton = true;
        break;
      case 'CheckEditing':
        isTheCheckEditingButton = true;
        break;
      case 'Save_After_Editing':
        isTheSaveAfterEditingButton = true;
        isbuttonDisabled = true;
        isTheSaveButton = true;
        break;
      case 'Save':
        isTheSaveButton = true;
        isbuttonDisabled = true;
        break;
    }

    return isTheSaveButton
        ? ElevatedButton(
            onPressed: isbuttonDisabled
                ? null
                : () {
                    swithCases(widget.type, context, false, widget.dropdownKey,
                        widget.text, widget.subType);
                  },
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    isbuttonDisabled ? greenLightColor : greenDarkColor,
                shadowColor: const Color.fromARGB(255, 7, 36, 86),
                elevation: 5.0),
            child: Text(
              isTheSaveAfterEditingButton ? 'Save' : widget.type,
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            ))
        : IconButton(
            onPressed: () {
              swithCases(widget.type, context, isTheCopyButton ? true : false,
                  widget.dropdownKey, widget.text, widget.subType);
            },
            icon: Icon(
                isTheCopyButton
                    ? Icons.copy
                    : isTheEditButton
                        ? Icons.edit
                        : isTheCheckEditingButton
                            ? Icons.check_outlined
                            : Icons.save,
                color: amberColor));
  }
}
