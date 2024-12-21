import 'package:flutter/material.dart';
import 'package:playbook/src/models/database_helper.dart';
import 'package:playbook/src/provider/provider.dart';
import 'package:playbook/utils/colors.dart';
import 'package:playbook/utils/text_styles.dart';
import 'package:playbook/widgets/dropdown/add_item_dropdown.dart';
// import 'package:playbook/widgets/dropdown/add_item_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class DropdownSection extends StatefulWidget {
  final String page;
  const DropdownSection({super.key, required this.page});

  @override
  State<DropdownSection> createState() => DropdownSectionState();
}

class DropdownSectionState extends State<DropdownSection> {
  String? dropDownValue;
  List<String> dropdownItems = [];
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  //
  ///Load the dropdown list from the db
  Future<void> loadDropdownItems() async {
    final items = await databaseHelper.getDropdownItems();
    setState(() {
      dropdownItems = items;
    });
  }

  //
  @override
  void initState() {
    super.initState();
    loadDropdownItems();
  }

  //
  void resetDropdown() {
    setState(() {
      dropDownValue = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    // Filtered list based on the type
    // Exclude "+ Add More" if type is "read"
    List<String> filteredDropdownItems = dropdownItems.where((item) {
      if (widget.page == 'read') {
        return item != '+ Add More';
      }
      return true; // Include all items for other types
    }).toList();
//
    return DropdownButton2<String>(
      key: const Key('dropDownValue'),
      hint: const Text(
        'Section',
        overflow: TextOverflow.ellipsis,
      ).dropDownTextStyle(),
      items: [
        ...filteredDropdownItems.map((item) => DropdownMenuItem<String>(
              value: item,
              child:
                  Text(item, textAlign: TextAlign.center).dropDownTextStyle(),
            ))
      ],
      value: dropDownValue,
      onChanged: (newValue) async {
        if (newValue == '+ Add More' && widget.page == 'insert') {
          String? newItemValue = await addItemToDropdown(context, setState);
          if (newItemValue != "" && newItemValue.isNotEmpty) {
            dropdownItems.insert(dropdownItems.length - 1, newItemValue);
            setState(() {
              dropDownValue = newItemValue;
            });
          }
        } else {
          setState(() {
            dropDownValue = newValue;
            Provider.of<DataBaseProvider>(context, listen: false)
                .dataToBeSearch(newValue!);
          });
        }
      },
      buttonStyleData: ButtonStyleData(
        height: 50,
        width: 160,
        padding: const EdgeInsets.only(left: 14, right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: orangeColor,
        ),
        elevation: 2,
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_forward_ios_outlined,
        ),
        iconSize: 14,
        iconEnabledColor: blackColor,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: orangeColor,
        ),
        offset: const Offset(-20, 0),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: WidgetStateProperty.all(6),
          thumbVisibility: WidgetStateProperty.all(true),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
        padding: EdgeInsets.only(left: 14, right: 14),
      ),
    );
  }
}
