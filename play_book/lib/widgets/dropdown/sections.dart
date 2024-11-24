import 'package:flutter/material.dart';
import 'package:play_book/src/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Sections extends StatefulWidget {
  final String page;
  const Sections({super.key, required this.page});

  @override
  State<Sections> createState() => _SectionsState();
}

class _SectionsState extends State<Sections> {
  String? dropDownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<String>(
      isExpanded: true,
      hint: const Expanded(
        child: Text(
          'Section',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      items: <String>[
        'Flutter',
        'NextJS',
        'React',
        'NodeJS',
        'Database',
        'Backend',
        'Figma',
        'Websites',
        'General'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              textAlign: TextAlign.center,
            ));
      }).toList(),
      value: dropDownValue,
      onChanged: (newValue) {
        if (newValue != null) {
          setState(() {
            dropDownValue = newValue;
          });
        }
        if (widget.page == 'insert') {
          //Update Providers according once the dropdown changed.
          Provider.of<DataBaseProvider>(context, listen: false)
              .selectSection(newValue!);
        } else {
          Provider.of<DataBaseProvider>(context, listen: false)
              .dataToBeSearch(newValue!);
        }
      },
      buttonStyleData: ButtonStyleData(
        height: 50,
        width: 160,
        padding: const EdgeInsets.only(left: 14, right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          // border: Border.all(
          //   color: Colors.black26,
          // ),
          color: Colors.orange[400],
        ),
        elevation: 2,
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_forward_ios_outlined,
        ),
        iconSize: 14,
        iconEnabledColor: Colors.black,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.orange[400],
        ),
        offset: const Offset(-20, 0),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: MaterialStateProperty.all(6),
          thumbVisibility: MaterialStateProperty.all(true),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
        padding: EdgeInsets.only(left: 14, right: 14),
      ),
    );
  }
}
