import 'package:flutter/material.dart';
import 'package:playbook/src/provider/provider.dart';
import 'package:playbook/utils/colors.dart';
import 'package:playbook/utils/screen_size.dart';
import 'package:playbook/widgets/buttons/dynamic_buttons/dynamic_buttons.dart';
import 'package:provider/provider.dart';

class TextFieldDialog extends StatefulWidget {
  final String subject;
  const TextFieldDialog({super.key, required this.subject});

  @override
  State<TextFieldDialog> createState() => _TextFieldDialogState();
}

class _TextFieldDialogState extends State<TextFieldDialog> {
  /// Controllers for each one of the dialog boxes (Code and Descritption):
  /// set up here to avoid rebuilt and lost of information as well as separate
  /// as needed to avoid information missplaced.
  late TextEditingController codeController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with text from provider
    final provider = Provider.of<DataBaseProvider>(context, listen: false);
    codeController = TextEditingController(text: provider.code);
    descriptionController = TextEditingController(text: provider.description);
  }

  @override
  Widget build(BuildContext context) {
    //
    ScreenSize myScreenSize = ScreenSize(context);
    String section = context.watch<DataBaseProvider>().data.section;
    bool isActive = context.watch<DataBaseProvider>().data.isActive;

    return AlertDialog(
      key: const Key('AlertDialog TextEditing'),
      insetPadding: const EdgeInsets.symmetric(horizontal: 150, vertical: 50),
      titlePadding: const EdgeInsets.only(top: 30, left: 25, right: 10),
      title: title(myScreenSize.screenWidth, myScreenSize.screenHeight,
          widget.subject, context),
      content: content(myScreenSize.screenWidth, myScreenSize.screenHeight,
          context, section, isActive, codeController, descriptionController),
      actions: const <Widget>[
        DynamicActionButton(
          type: 'Save_After_Editing',
        ),
        CloseButton(),
      ],
    );
  }

  ///title:
  static Widget title(screenWidth, screenHeight, title, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                greenColor,
                blueShadowColor,
              ])),
      width: screenWidth * 0.9,
      height: screenHeight * 0.10,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10),
        child: Text('$title',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: blackColor)),
      ),
    );
  }

  ///content and description:
  static Widget content(screenWidth, screenHeight, BuildContext context,
      section, isActive, codeController, descriptionController) {
    //
    bool isEditCode = section == "Code" && isActive == true;
    bool isEditDescription = section == "Description" && isActive == true;

    //
    return SizedBox(
        width: screenWidth * 0.9,
        height: screenHeight * 0.8,
        child: Column(children: [
          contentSection(screenWidth, screenHeight, isEditCode, context,
              codeController, "Code"),
          const Padding(padding: EdgeInsets.only(top: 10)),
          contentSection(screenWidth, screenHeight, isEditDescription, context,
              descriptionController, "Description"),
        ]));
  }

  ///Dialog Shape:
  static Widget contentSection(double screenWidth, double screenHeight,
      bool isEdit, BuildContext context, controller, String section) {
    //
    return Stack(
        alignment: AlignmentDirectional.bottomStart,
        fit: StackFit.loose,
        children: [
          SizedBox(
              width: screenWidth * 0.95,
              height: screenHeight * 0.22,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: blueShadowColor),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: isEdit
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: TextField(
                            maxLines: controller.text.split('\n').length + 2,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: whiteColor),
                            controller: controller,
                            onChanged: (value) {
                              if (section == "Code") {
                                Provider.of<DataBaseProvider>(context,
                                        listen: false)
                                    .editedCode(value);
                              } else {
                                Provider.of<DataBaseProvider>(context,
                                        listen: false)
                                    .editedDescription(value);
                              }
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: SelectableText(
                            '\n ${controller.text}',
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: whiteColor),
                          ),
                        ),
                ),
              )),
          Positioned(
              top: 5,
              right: 5,
              child: DynamicActionButton(type: 'Copy', text: controller.text)),
          Positioned(
              top: 5,
              right: 45,
              child: DynamicActionButton(
                type: isEdit ? 'Check' : 'Edit',
                subType: section,
              )),
        ]);
  }

  @override
  void dispose() {
    codeController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
