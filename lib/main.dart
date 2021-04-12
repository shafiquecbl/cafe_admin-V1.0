import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cafe_admin/routes.dart';
import 'package:cafe_admin/screens/sign_in/sign_in_screen.dart';
import 'package:cafe_admin/theme.dart';
import 'package:cafe_admin/screens/Home_Screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Firebase.apps.length == 1) {
      createFBapp();
    }
    User user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin App',
      theme: theme(),
      initialRoute: user != null && user.emailVerified
          ? HomeScreen.routeName
          : SignInScreen.routeName,
      routes: routes,
    );
  }

  createFBapp() async {
    await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);
  }
}
