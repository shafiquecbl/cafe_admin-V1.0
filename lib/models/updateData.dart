import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:cafe_admin/screens/Home_Screen/home_screen.dart';
import 'package:cafe_admin/widgets/snack_bar.dart';

class UpdateData {
  User user = FirebaseAuth.instance.currentUser;
  final email = FirebaseAuth.instance.currentUser.email;

  Future saveUserProfile(context, name, gender, phNo) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('Users');
    users
        .doc(email)
        .update(
          {
            'Name': name,
            'Phone Number': phNo,
            'Gender': gender,
            'PhotoURL': "",
          },
        )
        .then((value) =>
            Navigator.pushReplacementNamed(context, HomeScreen.routeName))
        .catchError((e) {
          Snack_Bar.show(context, e.message);
        });
  }
}
