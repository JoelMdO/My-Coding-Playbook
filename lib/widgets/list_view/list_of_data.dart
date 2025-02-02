import 'package:flutter/material.dart';
import 'package:playbook/src/models/database_helper.dart';
import 'package:playbook/src/models/model.dart';
import 'package:playbook/src/provider/provider.dart';
import 'package:playbook/utils/colors.dart';
import 'package:playbook/widgets/dialog/textfield_dialog.dart';
import 'package:provider/provider.dart';

class ListOfDataRetrievedFromDB extends StatefulWidget {
  const ListOfDataRetrievedFromDB({super.key});

  @override
  State<ListOfDataRetrievedFromDB> createState() =>
      _ListOfDataRetrievedFromDBState();
}

class _ListOfDataRetrievedFromDBState extends State<ListOfDataRetrievedFromDB> {
  //
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  String code = '', description = '';
  List<Data> dataList = [];
  void updateProviders(BuildContext context, subject, code, description) {
    Provider.of<DataBaseProvider>(context, listen: false)
        .insertSubject(subject!);
    Provider.of<DataBaseProvider>(context, listen: false).insertCode(code!);
    Provider.of<DataBaseProvider>(context, listen: false)
        .insertDescription(description!);
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    final searchValue = Provider.of<DataBaseProvider>(context).dataToSearch;
    //
    if (searchValue != null && searchValue.isNotEmpty) {
      return FutureBuilder<List<Data>>(
          future: databaseHelper.getData(searchValue),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  heightFactor: 0.5,
                  widthFactor: 0.5,
                  child: CircularProgressIndicator.adaptive());
            } else if (snapshot.hasError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: const Duration(seconds: 10),
                    backgroundColor: greenColor,
                    content: Text('Error: ${snapshot.error}')));
              });
              // Optionally, return an error widget
              return const Center(
                  child: Text(
                'An error occurred.',
                style: TextStyle(fontSize: 14),
              ));
            } else if (snapshot.hasData) {
              dataList = snapshot.data!;
              return Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    width: 800,
                    child: Table(
                        border: TableBorder.all(color: greenColor),
                        children: [
                          TableRow(
                              decoration: BoxDecoration(
                                color: amberColor,
                              ),
                              children: const [
                                TableCell(
                                    child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Subject',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ))),
                                TableCell(
                                    child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Code',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ))),
                                TableCell(
                                    child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Description',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ))))
                              ]),
                          ...dataList.map((data) => TableRow(children: [
                                TableCell(
                                    child: GestureDetector(
                                        onTap: () {
                                          updateProviders(context, data.subject,
                                              data.code, data.description);
                                          showDialog(
                                              context: context,
                                              builder: ((context) =>
                                                  TextFieldDialog(
                                                    subject: data.subject!,
                                                  )));
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              data.subject!,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )))),
                                TableCell(
                                    child: GestureDetector(
                                        onTap: () {
                                          updateProviders(context, data.subject,
                                              data.code, data.description);
                                          showDialog(
                                              context: context,
                                              builder: ((context) =>
                                                  TextFieldDialog(
                                                    subject: data.subject!,
                                                  )));
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              data.code!,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )))),
                                TableCell(
                                    child: GestureDetector(
                                        onTap: () {
                                          updateProviders(context, data.subject,
                                              data.code, data.description);
                                          showDialog(
                                              context: context,
                                              builder: ((context) =>
                                                  TextFieldDialog(
                                                    subject: data.subject!,
                                                  )));
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(data.description!,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                )))))
                              ]))
                        ]),
                  ),
                ),
              );
            } else {
              return const Center(
                  child: Text(
                'No data available',
              ));
            }
          });
    }
    return const SizedBox();
  }
}
