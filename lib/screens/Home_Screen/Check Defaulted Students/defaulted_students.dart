import 'package:cafe_admin/constants.dart';
import 'package:cafe_admin/widgets/customAppBar.dart';
import 'package:cafe_admin/widgets/offline.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CheckDefaultedStudents extends StatefulWidget {
  static String routeName = "/defaulted_students";
  @override
  _CheckDefaultedStudentsState createState() => _CheckDefaultedStudentsState();
}

class _CheckDefaultedStudentsState extends State<CheckDefaultedStudents> {
  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          return Container(child: connected ? body(context) : offline);
        },
        child: Container());
  }

  Widget body(BuildContext context) {
    return Scaffold(
        appBar: customAppBar('Defaulted Students'),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .where('Remaining Dues', isGreaterThanOrEqualTo: 10000)
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
                  'No Defaulted Students',
                  style: GoogleFonts.teko(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              );

            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return studentList(snapshot.data.docs[index]);
                });
          },
        ));
  }

  studentList(DocumentSnapshot snapshot) {
    return Card(
      elevation: 2,
      shadowColor: kPrimaryColor,
      child: ExpansionTile(
        leading: Container(
          width: 55,
          height: 55,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            border: Border.all(
              width: 2,
              color: Theme.of(context).primaryColor,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(50),
            ),
            constraints: BoxConstraints(
              minWidth: 55,
              minHeight: 55,
            ),
            child: Center(
              child: Text(
                '${(snapshot['Name'].trim().split(' ').first)[0]}${(snapshot['Name'].trim().trimLeft().split(' ').last)[0]}',
                style: GoogleFonts.teko(
                  color: kPrimaryColor,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        title: Text(snapshot['Registeration No'].toUpperCase(),
            style: GoogleFonts.teko(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.7))),
        subtitle: Text(
          snapshot['Name'],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text('Remaining Dues: Rs.${snapshot['Remaining Dues']}',
                style: GoogleFonts.teko(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
          )
        ],
      ),
    );
  }
}
