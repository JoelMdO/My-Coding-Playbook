import 'package:flutter/material.dart';
import 'package:playbook/src/models/database_helper.dart';
import 'package:playbook/src/provider/provider.dart';
import 'package:playbook/utils/screen_size.dart';
import 'package:playbook/widgets/buttons/dynamic_buttons/dynamic_buttons.dart';
import 'package:playbook/widgets/buttons/exit_button.dart';
import 'package:playbook/widgets/buttons/home_page_init_button.dart';
import 'package:playbook/widgets/dropdown/dropdown.dart';
import 'package:playbook/widgets/textfield/data_insert.dart';
import 'package:provider/provider.dart';

class InsertData extends StatefulWidget {
  const InsertData({super.key});

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  //
  final GlobalKey<DropdownSectionState> dropdownKey =
      GlobalKey<DropdownSectionState>();
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    databaseHelper.initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    //
    ScreenSize myScreenSize = ScreenSize(context);

    //
    return ChangeNotifierProvider(
        create: (context) => DataBaseProvider(),
        child: MaterialApp(
            // Add MaterialApp widget
            home: Directionality(
          // Add Directionality widget
          textDirection: TextDirection
              .ltr, // Adjust this according to your app's language direction
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Playbook',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Image.asset('assets/bafik.png', width: 100, height: 100),
                  const ExitButton(),
                ],
              ),
              backgroundColor: const Color.fromARGB(255, 125, 186, 3),
            ),
            body: SizedBox(
                width: myScreenSize.screenWidth,
                height: myScreenSize.screenHeight,
                child: Stack(
                    alignment: AlignmentDirectional.topStart,
                    fit: StackFit.loose,
                    children: [
                      Positioned(
                          left: 40,
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(height: 50),
                                    SizedBox(
                                      width: 500,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Select:',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 50),
                                          DropdownSection(
                                              key: dropdownKey, page: 'insert'),
                                        ],
                                        // )
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    DataInsertField(
                                      type: 'Subject',
                                    ),
                                    SizedBox(height: 20),
                                    DataInsertField(
                                      type: 'Code',
                                    ),
                                    SizedBox(height: 20),
                                    DataInsertField(
                                      type: 'Description',
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                        width: 500,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            DynamicActionButton(
                                              type: 'Save',
                                              dropdownKey: dropdownKey,
                                            ),
                                            DynamicActionButton(
                                              type: 'Clear',
                                            ),
                                            HomePageInitButton(type: 'Read')
                                          ],
                                        )),
                                  ]))),
                      Positioned(
                          bottom: 10,
                          right: 10,
                          child: Image.asset('assets/bafik.png')),
                    ])),
          ),
        )));
  }
}
