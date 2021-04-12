import 'package:cafe_admin/constants.dart';
import 'package:cafe_admin/size_config.dart';
import 'package:cafe_admin/widgets/offline.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class History extends StatefulWidget {
  static String routeName = "/history";
  final String regNo;
  History({@required this.regNo});
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          return Container(child: connected ? body(context) : offline);
        },
        child: Container());
  }

  body(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          shadowColor: kPrimaryColor,
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Text(
              'History',
              style: GoogleFonts.teko(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          actions: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc('${widget.regNo}@students.cuisahiwal.edu.pk')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        'Remaining Dues:',
                        style: GoogleFonts.teko(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      'Remaining Dues: ${snapshot.data['Remaining Dues']}',
                      style: GoogleFonts.teko(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
          backgroundColor: hexColor,
          bottom: TabBar(
              labelColor: kPrimaryColor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: kPrimaryColor,
              tabs: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .doc('${widget.regNo}@students.cuisahiwal.edu.pk')
                      .collection("Funds")
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Tab(text: "Funds (0)");
                    }
                    return Tab(text: "Funds (${snapshot.data.docs.length})");
                  },
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .doc('${widget.regNo}@students.cuisahiwal.edu.pk')
                      .collection("Paid")
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Tab(text: "Paid (0)");
                    }
                    return Tab(text: "Paid (${snapshot.data.docs.length})");
                  },
                ),
              ]),
        ),
        body: TabBarView(
          children: [
            funds(),
            paid(),
          ],
        ),
      ),
    );
  }

  funds() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Users")
          .doc('${widget.regNo}@students.cuisahiwal.edu.pk')
          .collection("Funds")
          .orderBy('Date', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return SpinKitRing(
            lineWidth: 5,
            color: Colors.blue,
          );
        if (snapshot.data.docs.length == 0)
          return Center(
            child: Text(
              'No Funds yet',
              style: GoogleFonts.teko(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          );
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                showCheckboxColumn: false,
                columns: [
                  DataColumn(label: Text('Index')),
                  DataColumn(label: Text('Amount')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Date')),
                ],
                rows: List.generate(
                    snapshot.data.docs.length,
                    (index) => DataRow(
                            onSelectChanged: (value) {
                              dialog(context, snapshot.data.docs[index]);
                            },
                            cells: [
                              DataCell(Text('${index + 1}')),
                              DataCell(Text(
                                  '${snapshot.data.docs[index]['Amount']}')),
                              DataCell(Container(
                                child: Text(
                                    '${snapshot.data.docs[index]['Reason']}'),
                              )),
                              DataCell(
                                  Text('${snapshot.data.docs[index]['Date']}')),
                            ]))),
          ),
        );
      },
    );
  }

  Future<Widget> dialog(BuildContext context, DocumentSnapshot snapshot) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.fromLTRB(4, 4, 4, 4),
            elevation: 10,
            backgroundColor: kPrimaryColor.withOpacity(0.8),
            children: [
              SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            height: 50,
                            color: Colors.blueGrey[200].withOpacity(0.3),
                            child: Text(
                              'Amount',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.7)),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 20),
                            child: Text(
                              '${snapshot['Amount']}',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.7)),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            height: 50,
                            color: Colors.blueGrey[200].withOpacity(0.3),
                            child: Text(
                              'Description',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.7)),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 20),
                            child: Text(
                              snapshot['Reason'],
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.7)),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            height: 50,
                            color: Colors.blueGrey[200].withOpacity(0.3),
                            child: Text(
                              'Date',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.7)),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 20),
                            child: Text(
                              snapshot['Date'],
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.7)),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          );
        });
  }

  paid() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Users")
          .doc('${widget.regNo}@students.cuisahiwal.edu.pk')
          .collection("Paid")
          .orderBy('Date', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return SpinKitRing(
            lineWidth: 5,
            color: Colors.blue,
          );
        if (snapshot.data.docs.length == 0)
          return Center(
            child: Text(
              'No Paid amount yet',
              style: GoogleFonts.teko(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          );
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                columns: [
                  DataColumn(label: Text('Index')),
                  DataColumn(label: Text('Amount')),
                  DataColumn(label: Text('Date')),
                ],
                rows: List.generate(
                    snapshot.data.docs.length,
                    (index) => DataRow(cells: [
                          DataCell(Text('${index + 1}')),
                          DataCell(
                              Text('${snapshot.data.docs[index]['Amount']}')),
                          DataCell(
                              Text('${snapshot.data.docs[index]['Date']}')),
                        ]))),
          ),
        );
      },
    );
  }
}
