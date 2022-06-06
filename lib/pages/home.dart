import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<List<dynamic>> csvData = [
    [
      "ID",
      "Campus",
      "Block Name",
      "Date",
      "Time",
      "Photo",
      "Location",
      "Vidio",
      "Mobile",
      "Email",
      "Additional Remarks"
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Download CSV",
        onPressed: () => csvData.length == 1 ? null : downloadCSV(),
        child: const Icon(Icons.download),
      ),
    );
  }

  FutureBuilder<QuerySnapshot<Object>> buildBody() {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('upload')
            .orderBy("time", descending: true)
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length > 0) {
              List<TableRow> tableData = [
                const TableRow(
                    decoration: BoxDecoration(color: Colors.green),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: SelectableText(
                          'ID',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: SelectableText(
                          'Campus',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: SelectableText(
                          'Block Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: SelectableText(
                          'Date',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: SelectableText(
                          'Time',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: SelectableText(
                          'Photo',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: SelectableText(
                          'Location',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: SelectableText(
                          'Video',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: SelectableText(
                          'Mobile',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: SelectableText(
                          'Email',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: SelectableText(
                          'Additional Remarks',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ])
              ];
              for (int i = 0; i < snapshot.data.docs.length; i++) {
                var data = snapshot.data.docs[i];
                Timestamp timestamp = data['time'];
                DateTime dateTime = timestamp.toDate();
                List<dynamic> dataRow = [];
                dataRow.add("${i + 1}");
                dataRow.add(data["campus"]);
                dataRow.add(data["block"]);

                dataRow.add(
                    "${dateTime.year}-${dateTime.month.toString().padLeft(1, '0')}-${dateTime.day.toString().padLeft(1, '0')}");
                dataRow.add(
                    "${dateTime.hour.toString().padLeft(1, '0')}:${dateTime.minute.toString().padLeft(1, '0')}");
                dataRow.add(data["photoUrl"]);
                dataRow.add(data["location"]);
                dataRow.add(data["videoUrl"]);
                dataRow.add(data["mobile"]);
                dataRow.add(data["email"]);
                dataRow.add(data["note"]);
                csvData.add(dataRow);
                tableData.add(TableRow(
                    decoration: BoxDecoration(
                        color: i % 2 == 0 ? Colors.white : Colors.grey[300]),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SelectableText("${i + 1}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SelectableText(data['campus']),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SelectableText(data["block"]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SelectableText(
                            "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SelectableText(
                            "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: data['photoUrl'] == "N/A"
                              ? null
                              : () => link(Uri.parse(data['photoUrl'])),
                          child: data['photoUrl'] == "N/A"
                              ? const SelectableText("N/A")
                              : const Text(
                                  "Download Photo",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue),
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                            onTap: () => link(Uri.parse(data['location'])),
                            child: const Text("Open",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue))),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: InkWell(
                            onTap: data['videoUrl'] == "N/A"
                                ? null
                                : () => link(Uri.parse(data['videoUrl'])),
                            child: data['videoUrl'] == "N/A"
                                ? const SelectableText("N/A")
                                : const Text(
                                    "Download Video",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue),
                                  ),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SelectableText(data['mobile']),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SelectableText(data['email']),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SelectableText(data['note']),
                      ),
                    ]));
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 30),
                        child: Text(
                          "History",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Table(
                        columnWidths: const {
                          9: FractionColumnWidth(0.1),
                          10: FractionColumnWidth(0.3)
                        },
                        border: TableBorder.all(color: Colors.black),
                        children: tableData,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  "No Data Found !",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              );
            }
          }
          return const Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  link(Uri url) async {
    await launchUrl(url);
  }

  void downloadCSV() async {
    String csv = const ListToCsvConverter().convert(csvData);
    final content = base64Encode(csv.codeUnits);
    final url = 'data:application/csv;base64,$content';
    await launchUrl(Uri.parse(url));
  }
}
