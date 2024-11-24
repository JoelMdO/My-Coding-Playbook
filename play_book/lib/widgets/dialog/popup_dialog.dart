import 'package:flutter/material.dart';
import 'package:play_book/src/provider/provider.dart';
import 'package:play_book/utils/screen_size.dart';
import 'package:play_book/widgets/button/copy_button.dart';
import 'package:play_book/widgets/button/edit_button.dart';
import 'package:play_book/widgets/button/save_button.dart';
import 'package:provider/provider.dart';

class PopUpDialog extends StatefulWidget {
  final String subject;
  const PopUpDialog({super.key, required this.subject});

  @override
  State<PopUpDialog> createState() => _PopUpDialogState();
}

class _PopUpDialogState extends State<PopUpDialog> {
  @override
  Widget build(BuildContext context) {
    //
    ScreenSize myScreenSize = ScreenSize(context);
    bool isEdit = context.watch<DataBaseProvider>().isEdit;

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 200, vertical: 50),
      titlePadding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      title: buildTitleProjectsDialog(myScreenSize.screenWidth,
          myScreenSize.screenHeight, widget.subject, context),
      content: buildContentProjectsDialog(
          myScreenSize.screenWidth, myScreenSize.screenHeight, isEdit, context),
      actions: <Widget>[
        const EditButton(),
        if (isEdit) const SaveButton(),
        const CloseButton(),
      ],
    );
  }

  ///title:
  static Widget buildTitleProjectsDialog(
      screenWidth, screenHeight, title, BuildContext context) {
    final text = context.read<DataBaseProvider>().code;
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromARGB(255, 125, 186, 3),
                  Color.fromARGB(255, 7, 36, 86),
                ])),
        width: screenWidth / 2,
        height: screenHeight * 0.15,
        child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\n $title',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                CopyButton(text: text)
              ],
            )));
  }

  ///content:
  static Widget buildContentProjectsDialog(
      screenWidth, screenHeight, isEdit, BuildContext context) {
    //
    TextEditingController controller = TextEditingController();
    final textController = context.read<DataBaseProvider>().code;
    controller.text = textController;
    //
    return SizedBox(
      width: screenWidth * 0.9,
      height: screenHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black.withOpacity(0.8)),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: isEdit
              ? TextField(
                  maxLines: controller.value.text.split('\n').length,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.white),
                  controller: controller,
                  onChanged: (value) {
                    Provider.of<DataBaseProvider>(context, listen: false)
                        .changedCode(value);
                  },
                )
              : SelectableText(
                  '\n $textController',
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.white),
                ),
        ),
      ),
    );
  }
}
