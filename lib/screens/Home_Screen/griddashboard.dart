import 'package:cafe_admin/screens/Home_Screen/Add%20Amount%20in%20Student%20Fund/add_amount.dart';
import 'package:cafe_admin/screens/Home_Screen/Check%20Defaulted%20Students/defaulted_students.dart';
import 'package:cafe_admin/screens/Home_Screen/Check%20Remaing%20Dues/check_remaining_dues.dart';
import 'package:cafe_admin/screens/Home_Screen/Check%20Studens%20List%20Under%20Registeration/check_students_list.dart';
import 'package:cafe_admin/screens/Home_Screen/Pay%20Bill/pay_bill.dart';
import 'package:cafe_admin/screens/Home_Screen/Print%20Challan/print_challan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cafe_admin/constants.dart';
import 'package:cafe_admin/screens/Home_Screen/Teachers/add_teachers.dart';
import 'History/check_history.dart';
import 'Students/Add Students/add_students.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        staggeredTiles: [
          StaggeredTile.extent(1, 120),
          StaggeredTile.extent(1, 120),
          StaggeredTile.extent(1, 120),
          StaggeredTile.extent(1, 120),
          StaggeredTile.extent(1, 120),
          StaggeredTile.extent(1, 120),
          StaggeredTile.extent(1, 120),
          StaggeredTile.extent(1, 120),
          StaggeredTile.extent(1, 120),
        ],
        children: [
          checkStudentsList(context),
          student(context),
          teacher(context),
          checkRemainingDuesStudent(context),
          printChallan(context),
          checkDefaultedStudent(context),
          addAmountInStudentFund(context),
          payBill(context),
          history(context),
        ],
      ),
    );
  }

  teacher(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AddTeachers.routeName);
      },
      splashColor: kPrimaryColor,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kCardColor,
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(2, 0),
          )
        ], color: kCardColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/icons/teacher.svg",
              color: kTextFieldColor,
              width: 42,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "Add Teachers",
              style: stylee,
            ),
          ],
        ),
      ),
    );
  }

  student(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AddStudents.routeName);
      },
      splashColor: kPrimaryColor,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kCardColor,
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(2, 0),
          )
        ], color: kCardColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/icons/student.svg",
              color: kTextFieldColor,
              width: 42,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "Add Students",
              style: stylee,
            ),
          ],
        ),
      ),
    );
  }

  printChallan(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, PrintChallan.routeName);
      },
      splashColor: kPrimaryColor,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kCardColor,
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(2, 0),
          )
        ], color: kCardColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.print_outlined,
              color: kTextFieldColor,
              size: 42,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "Print Challan",
              style: stylee,
            ),
          ],
        ),
      ),
    );
  }

  history(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CheckHistory.routeName);
      },
      splashColor: kPrimaryColor,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kCardColor,
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(2, 0),
          )
        ], color: kCardColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.history_outlined,
              color: kTextFieldColor,
              size: 42,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "History",
              style: stylee,
            ),
          ],
        ),
      ),
    );
  }

  checkStudentsList(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CheckStudentsList.routeName);
      },
      splashColor: kPrimaryColor,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kCardColor,
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(2, 0),
          )
        ], color: kCardColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/icons/User.svg",
              color: kTextFieldColor,
              width: 42,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "Check Students",
              style: stylee,
            ),
          ],
        ),
      ),
    );
  }

  checkDefaultedStudent(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CheckDefaultedStudents.routeName);
      },
      splashColor: kPrimaryColor,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kCardColor,
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(2, 0),
          )
        ], color: kCardColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/icons/defaulters.svg",
              color: kTextFieldColor,
              width: 42,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "Defaulted Students",
              textAlign: TextAlign.center,
              style: stylee,
            ),
          ],
        ),
      ),
    );
  }

  checkRemainingDuesStudent(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CheckRemainingDues.routeName);
      },
      splashColor: kPrimaryColor,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kCardColor,
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(2, 0),
          )
        ], color: kCardColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.money,
              color: kTextFieldColor,
              size: 42,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "Remaining Dues",
              textAlign: TextAlign.center,
              style: stylee,
            ),
          ],
        ),
      ),
    );
  }

  payBill(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, PayBill.routeName);
      },
      splashColor: kPrimaryColor,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kCardColor,
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(2, 0),
          )
        ], color: kCardColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.payment_outlined,
              color: kTextFieldColor,
              size: 42,
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "Pay Bill",
              textAlign: TextAlign.center,
              style: stylee,
            ),
          ],
        ),
      ),
    );
  }

  addAmountInStudentFund(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AddAmount.routeName);
      },
      splashColor: kPrimaryColor,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: kCardColor,
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(2, 0),
          )
        ], color: kCardColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.add,
              color: kTextFieldColor,
              size: 42,
            ),
            SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "Add Fund",
                textAlign: TextAlign.center,
                style: stylee,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
