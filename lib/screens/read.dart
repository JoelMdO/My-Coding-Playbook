import 'package:flutter/material.dart';
import 'package:playbook/src/models/database_helper.dart';
import 'package:playbook/src/provider/provider.dart';
import 'package:playbook/utils/colors.dart';
import 'package:playbook/utils/screen_size.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:playbook/widgets/buttons/exit_button.dart';
import 'package:playbook/widgets/buttons/home_page_init_button.dart';
import 'package:playbook/widgets/dropdown/dropdown.dart';
import 'package:playbook/widgets/list_view/list_of_data.dart';
import 'package:provider/provider.dart';

class Read extends StatefulWidget {
  const Read({super.key});

  @override
  State<Read> createState() => _ReadState();
}

class _ReadState extends State<Read> {
  //
  TextEditingController controller = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  bool? result;
  //

  @override
  Widget build(BuildContext context) {
    //
    ScreenSize myScreenSize = ScreenSize(context);
    String dataToSearch = Provider.of<DataBaseProvider>(context).dataToSearch;
    // Triggering rebuild if 'true' is passed from the Save page
    if (result == true) {
      // Reload or fetch your data again here
      setState(() {
        dataToSearch = Provider.of<DataBaseProvider>(context).dataToSearch;
      });
    }
    //
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Playbook'),
              Image.asset('assets/byJoel.png', width: 80, height: 80),
              const ExitButton(),
            ],
          ),
          backgroundColor: greenColor,
        ),
        body: SizedBox(
            width: myScreenSize.screenWidth,
            height: myScreenSize.screenHeight,
            child: Column(children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    AnimSearchBar(
                      width: myScreenSize.screenWidth * 0.3,
                      color: orangeColor,
                      textController: controller,
                      onSuffixTap: () {
                        setState(() {
                          controller.clear();
                        });
                      },
                      onSubmitted: (controller) {
                        Provider.of<DataBaseProvider>(context, listen: false)
                            .dataToBeSearch(controller);
                      },
                    ),
                    const DropdownSection(page: 'read'),
                  ]),
              SizedBox(
                width: myScreenSize.screenWidth * 0.9,
                height: myScreenSize.screenHeight * 0.55,
                child: dataToSearch.isEmpty
                    ? const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Select a value to search',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ))
                    : const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: ListOfDataRetrievedFromDB()),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const HomePageInitButton(type: 'Go to Insert Page'),
                          const Padding(padding: EdgeInsets.only(bottom: 5)),
                          Image.asset('assets/byJoel.png',
                              width: 70, height: 70),
                        ]),
                  ))
            ])));
  }
}
