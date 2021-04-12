import 'package:cafe_admin/widgets/offline.dart';
import 'package:flutter/material.dart';
import 'package:cafe_admin/size_config.dart';
import 'package:cafe_admin/widgets/customAppBar.dart';
import 'add_teachers.form.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_offline/flutter_offline.dart';

class AddTeachers extends StatelessWidget {
  static String routeName = "/add_teachers";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: OfflineBuilder(
            connectivityBuilder: (BuildContext context,
                ConnectivityResult connectivity, Widget child) {
              final bool connected = connectivity != ConnectivityResult.none;
              return Container(child: connected ? body(context) : offline);
            },
            child: Container()));
  }

  Widget body(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Add Teachers"),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  Text(
                    "Enter Details",
                    style: GoogleFonts.teko(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  AddTeachersForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
