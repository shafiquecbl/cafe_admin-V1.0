import 'package:cafe_admin/screens/Home_Screen/Add%20Amount%20in%20Student%20Fund/add_amount.dart';
import 'package:cafe_admin/screens/Home_Screen/Check%20Defaulted%20Students/defaulted_students.dart';
import 'package:cafe_admin/screens/Home_Screen/Check%20Remaing%20Dues/check_remaining_dues.dart';
import 'package:cafe_admin/screens/Home_Screen/Check%20Studens%20List%20Under%20Registeration/check_students_list.dart';
import 'package:cafe_admin/screens/Home_Screen/History/check_history.dart';
import 'package:cafe_admin/screens/Home_Screen/Pay%20Bill/pay_bill.dart';
import 'package:cafe_admin/screens/Home_Screen/Print%20Challan/print_challan.dart';
import 'package:cafe_admin/screens/Home_Screen/Students/Add%20Students/add_students.dart';
import 'package:cafe_admin/screens/Home_Screen/Teachers/add_teachers.dart';
import 'package:flutter/widgets.dart';
import 'package:cafe_admin/models/verify_email.dart';
import 'package:cafe_admin/screens/complete_profile/complete_profile_screen.dart';
import 'package:cafe_admin/screens/forgot_password/forgot_password_screen.dart';
import 'package:cafe_admin/screens/sign_in/sign_in_screen.dart';
import 'package:cafe_admin/screens/Home_Screen/home_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  VerifyEmail.routeName: (context) => VerifyEmail(),
  AddTeachers.routeName: (context) => AddTeachers(),
  AddStudents.routeName: (context) => AddStudents(),
  CheckStudentsList.routeName: (context) => CheckStudentsList(),
  CheckRemainingDues.routeName: (context) => CheckRemainingDues(),
  CheckDefaultedStudents.routeName: (context) => CheckDefaultedStudents(),
  AddAmount.routeName: (context) => AddAmount(),
  PayBill.routeName: (context) => PayBill(),
  PrintChallan.routeName: (context) => PrintChallan(),
  CheckHistory.routeName: (context) => CheckHistory(),
};
