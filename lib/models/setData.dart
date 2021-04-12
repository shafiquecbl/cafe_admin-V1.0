import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:cafe_admin/screens/complete_profile/complete_profile_screen.dart';
import 'package:intl/intl.dart';
import 'package:cafe_admin/widgets/snack_bar.dart';

class SetData {
  String uid = FirebaseAuth.instance.currentUser.uid.toString();
  static DateTime now = DateTime.now();
  String dateTime = DateFormat("dd-MM-yyyy h:mma").format(now);

  Future saveNewUser(email, context) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('Users');
    users
        .doc(email)
        .set({'Email': email, 'Uid': uid, 'Role': "Admin"})
        .then((value) => Navigator.pushReplacementNamed(
            context, CompleteProfileScreen.routeName))
        .catchError((e) {
          print(e);
        });
  }

  Future addStudent(context,
      {@required name, @required email, @required regNo}) async {
    return await FirebaseFirestore.instance.collection('Users').doc(email).set({
      'Name': name,
      'Email': email,
      'Registeration No': regNo,
      'Remaining Dues': 0,
      'Role': "Student",
    }).then((value) {
      Navigator.pop(context);
      Snack_Bar.show(context, "Student added successfully!");
    }).catchError((e) {
      Navigator.pop(context);
      Snack_Bar.show(context, e.message);
    });
  }

  Future addTeacher(context, {@required email, @required name}) async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .set({'Email': email, 'Name': name, 'Role': "Teacher"}).then((value) {
      Navigator.pop(context);
      Snack_Bar.show(context, "Teacher added successfully!");
    }).catchError((e) {
      Navigator.pop(context);
      Snack_Bar.show(context, e.message);
    });
  }

  Future addFund(
      {context, @required regNo, @required reason, @required amount}) async {
    int dues;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc('$regNo@students.cuisahiwal.edu.pk')
        .get()
        .then((value) => {dues = value['Remaining Dues']});
    await FirebaseFirestore.instance
        .collection('Users')
        .doc('$regNo@students.cuisahiwal.edu.pk')
        .update({'Remaining Dues': dues + amount});
    CollectionReference ref = FirebaseFirestore.instance
        .collection('Users')
        .doc('$regNo@students.cuisahiwal.edu.pk')
        .collection('Funds');
    return await ref.add({
      'Reason': reason,
      'Amount': amount,
      'Date': dateTime,
    }).then((value) {
      Navigator.pop(context);
      Snack_Bar.show(context, "Fund added successfully!");
    });
  }

  Future payBill({context, @required regNo, @required amount}) async {
    int dues;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc('$regNo@students.cuisahiwal.edu.pk')
        .get()
        .then((value) => {dues = value['Remaining Dues']});
    await FirebaseFirestore.instance
        .collection('Users')
        .doc('$regNo@students.cuisahiwal.edu.pk')
        .update({'Remaining Dues': dues - amount});
    CollectionReference ref = FirebaseFirestore.instance
        .collection('Users')
        .doc('$regNo@students.cuisahiwal.edu.pk')
        .collection('Paid');
    return await ref.add({
      'Amount': amount,
      'Date': dateTime,
    }).then((value) {
      Navigator.pop(context);
      Snack_Bar.show(context, "Bill Paid successfully!");
    });
  }
}
