import 'package:flutter/material.dart';
import 'package:play_book/src/models/database_helper.dart';
import 'package:play_book/src/models/model.dart';
import 'package:play_book/src/provider/provider.dart';
import 'package:play_book/widgets/dialog/popup_dialog.dart';
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
                    backgroundColor: const Color.fromARGB(255, 125, 186, 3),
                    content: Text('Error: ${snapshot.error}')));
              });
              // Optionally, return an error widget
              return const Center(
                  child: Text(
                'An error occurred.',
                style: TextStyle(fontSize: 20),
              ));
            } else if (snapshot.hasData) {
              dataList = snapshot.data!;
              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: FittedBox(
                      child: DataTable(
                          sortColumnIndex: 1,
                          border: TableBorder.all(
                            color: const Color.fromARGB(255, 125, 186, 3),
                          ),
                          dataRowColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              return Colors.amber.shade100;
                            },
                          ),
                          columns: const [
                            DataColumn(
                              label: Text(
                                'Subject',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Code',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                          rows: dataList
                              .map((data) => DataRow(cells: [
                                    DataCell(Text(data.subject!)),
                                    DataCell(SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: GestureDetector(
                                            onTap: () {
                                              Provider.of<DataBaseProvider>(
                                                      context,
                                                      listen: false)
                                                  .insertCode(data.code!);
                                              showDialog(
                                                  context: context,
                                                  builder: ((context) =>
                                                      PopUpDialog(
                                                        subject: data.subject!,
                                                      )));
                                            },
                                            child: Text(data.code!)))),
                                    DataCell(SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: GestureDetector(
                                            onTap: () {
                                              Provider.of<DataBaseProvider>(
                                                      context,
                                                      listen: false)
                                                  .insertDescription(
                                                      data.description!);
                                              showDialog(
                                                  context: context,
                                                  builder: ((context) =>
                                                      PopUpDialog(
                                                        subject: data.subject!,
                                                      )));
                                            },
                                            child: Text(data.description!)))),
                                  ]))
                              .toList())));
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
