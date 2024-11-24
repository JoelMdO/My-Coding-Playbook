import 'package:flutter/material.dart';
import 'package:play_book/src/provider/provider.dart';
import 'package:play_book/utils/screen_size.dart';
import 'package:play_book/widgets/textfield/is_code.dart';
import 'package:play_book/widgets/textfield/is_subject.dart';
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
          Text(
            widget.type,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          //SizedBox to move right the textfield.
          SizedBox(
              width: isSubject(widget.type)
                  ? 65
                  : isCode(widget.type)
                      ? 82
                      : 39),
          Expanded(
              child: TextField(
            maxLines: isSubject(widget.type) ? 1 : 3,
            //   isCode(type)
            //         ? 10
            //         : 10,
            focusNode: myFocusNode,
            controller: controllerProvider.textControllers[widget.type],
            decoration: InputDecoration(
                labelText: 'Type ${widget.type} here',
                labelStyle: TextStyle(color: Colors.grey[500], fontSize: 10),
                fillColor:
                    Colors.lime.shade100, // Change this to your desired color,
                floatingLabelAlignment: FloatingLabelAlignment.center,
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                  color:
                      Colors.lime.shade100, // Change this to your desired color
                  width: 2.0, // Change this to your desired width
                ))),
            onChanged: (value) {
              // FocusScope.of(context).nextFocus();
              switch (widget.type) {
                case 'Subject':
                  Provider.of<DataBaseProvider>(context, listen: false)
                      .insertSubject(value);
                  break;
                case 'Code':
                  Provider.of<DataBaseProvider>(context, listen: false)
                      .insertCode(value);
                  break;
                default:
                  Provider.of<DataBaseProvider>(context, listen: false)
                      .insertDescription(value);
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
