import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cafe_admin/components/custom_surfix_icon.dart';
import 'package:cafe_admin/components/default_button.dart';
import 'package:cafe_admin/components/form_error.dart';
import 'package:cafe_admin/constants.dart';
import 'package:cafe_admin/size_config.dart';
import 'package:cafe_admin/widgets/alert_dialog.dart';
import 'package:cafe_admin/widgets/outline_input_border.dart';
import 'package:cafe_admin/widgets/snack_bar.dart';
import 'package:cafe_admin/models/setData.dart';
import 'package:firebase_core/firebase_core.dart';

class AddStudentsForm extends StatefulWidget {
  @override
  _AddStudentsFormState createState() => _AddStudentsFormState();
}

class _AddStudentsFormState extends State<AddStudentsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  FirebaseApp fbApp = Firebase.app('Secondary');

  String email;
  String name;
  String password;

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Add Student",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                password = email.split('@').first;
                removeError(error: kInvalidEmailError);
                showLoadingDialog(context);
                print(password);
                createUser(name, email, password, context);
              }
            },
          ),
        ]));
  }

  //////////////////////////////////////////////////////////////////////////////

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue.toLowerCase().trim(),
      onChanged: (value) {
        setState(() {
          if (value.isNotEmpty) {
            removeError(error: kEmailNullError);
          }
          // else if (studentEmail.hasMatch(value)) {
          //   removeError(error: kInvalidEmailError);
          // }
          email = value.toLowerCase().trim();
        });
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        // else if (!studentEmail.hasMatch(value)) {
        //   addError(error: kInvalidEmailError);
        //   return "";
        // }
        return null;
      },
      decoration: InputDecoration(
        border: outlineBorder,
        labelText: "Email",
        hintText: "Enter email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        name = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        border: outlineBorder,
        labelText: "Name",
        hintText: "Enter name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  Future createUser(name, email, password, context) async {
    await FirebaseAuth.instanceFor(app: fbApp)
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      SetData().addStudent(context, name: name, email: email, regNo: password);
      FirebaseAuth.instanceFor(app: fbApp)
          .currentUser
          .updateProfile(displayName: name);
      FirebaseAuth.instanceFor(app: fbApp).signOut();
    }).catchError((e) {
      FirebaseAuth.instanceFor(app: fbApp).signOut();
      Navigator.pop(context);
      Snack_Bar.show(context, e.message);
    });
  }
}
