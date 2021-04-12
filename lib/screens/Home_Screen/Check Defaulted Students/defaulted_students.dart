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
    return ExpansionTile(
      leading: CircleAvatar(
          radius: 22,
          backgroundColor: Colors.grey[50],
          child: ClipRRect(
              borderRadius: BorderRadius.circular(70),
              child: Image.asset(
                'assets/images/nullUser.png',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ))),
      title: Text(snapshot['Registeration No'].toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.7))),
      subtitle: Text(snapshot['Name']),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text('Remaining Dues: Rs.${snapshot['Remaining Dues']}'),
        )
      ],
    );
  }
}
