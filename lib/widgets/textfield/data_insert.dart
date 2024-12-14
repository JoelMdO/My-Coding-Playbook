import 'package:flutter/material.dart';
import 'package:playbook/src/provider/provider.dart';
import 'package:playbook/utils/colors.dart';
import 'package:playbook/utils/screen_size.dart';
import 'package:playbook/widgets/textfield/is_subject.dart';
import 'package:playbook/widgets/textfield/update_provider_textfield.dart';
import 'package:provider/provider.dart';

class DataInsertField extends StatefulWidget {
  final String type;
  const DataInsertField({super.key, required this.type});

  @override
  State<DataInsertField> createState() => _DataInsertFieldState();
}

class _DataInsertFieldState extends State<DataInsertField> {
// Define the focus node. To manage the lifecycle, create the FocusNode in
  // the initState method, and clean it up in the dispose method.
  late FocusNode myFocusNode;
  final textControllers = <String, TextEditingController>{};

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    ScreenSize myScreenSize = ScreenSize(context);
    final controllerProvider = Provider.of<DataBaseProvider>(context);
    //
    return SizedBox(
      width: myScreenSize.screenWidth * 0.8,
      child: Row(
        children: <Widget>[
          SizedBox(
              width: myScreenSize.screenWidth * 0.8,
              child: TextField(
                maxLines: isSubject(widget.type) ? 1 : 3,
                focusNode: myFocusNode,
                controller: controllerProvider.textControllers[widget.type],
                decoration: InputDecoration(
                    labelText: 'Type ${widget.type} here',
                    labelStyle: TextStyle(
                        color: blueShadowColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    fillColor: limeColor,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: limeColor,
                      width: 2.0,
                    ))),
                onChanged: (value) {
                  switch (widget.type) {
                    case 'Subject':
                      updateProvidersonTextField(context, widget.type, value);
                      break;
                    case 'Code':
                      updateProvidersonTextField(context, widget.type, value);
                      break;
                    default:
                      updateProvidersonTextField(context, 'Description', value);
                      break;
                  }
                },
              ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    for (var controller in textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}
