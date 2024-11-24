import 'package:flutter/material.dart';
import 'package:play_book/src/models/database_helper.dart';
import 'package:play_book/src/provider/provider.dart';
import 'package:play_book/utils/screen_size.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:play_book/widgets/button/exit_button.dart';
import 'package:play_book/widgets/button/init_button.dart';
import 'package:play_book/widgets/dropdown/sections.dart';
import 'package:play_book/widgets/list_view/list_of_data.dart';
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
  //

  @override
  Widget build(BuildContext context) {
    //
    ScreenSize myScreenSize = ScreenSize(context);
    String dataToSearch = Provider.of<DataBaseProvider>(context).dataToSearch;
    //
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Playbook'),
              Image.asset('assets/bafik.png', width: 80, height: 80),
              const ExitButton(),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 125, 186, 3),
        ),
        body: SizedBox(
          width: myScreenSize.screenWidth,
          height: myScreenSize.screenHeight,
          child: Stack(children: [
            Align(
                alignment: Alignment.topCenter,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      AnimSearchBar(
                        width: myScreenSize.screenWidth * 0.3,
                        color: Colors.orange[400],
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
                      if (dataToSearch.isEmpty)
                        const Text(
                          'Select a value to search',
                          style: TextStyle(fontSize: 20),
                        ),
                      const Sections(page: 'read'),
                    ])),
            if (dataToSearch.isNotEmpty)
              Positioned(
                  top: 150,
                  left: 50,
                  child: SizedBox(
                    width: myScreenSize.screenWidth * 0.8,
                    child: const FittedBox(
                        fit: BoxFit.contain,
                        child: ListOfDataRetrievedFromDB()),
                  )),
            const Positioned(
              bottom: 150,
              right: 70,
              child: InitButton(type: 'Insert'),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Image.asset('assets/bafik.png'),
            ),
          ]),
        ));
  }
}
