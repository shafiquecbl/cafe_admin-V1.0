import 'package:cafe_admin/components/custom_surfix_icon.dart';
import 'package:cafe_admin/components/default_button.dart';
import 'package:cafe_admin/components/form_error.dart';
import 'package:cafe_admin/screens/Home_Screen/History/history.dart';
import 'package:cafe_admin/size_config.dart';
import 'package:cafe_admin/widgets/alert_dialog.dart';
import 'package:cafe_admin/widgets/outline_input_border.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckHistoryForm extends StatefulWidget {
  @override
  _CheckHistoryFormState createState() => _CheckHistoryFormState();
}

class _CheckHistoryFormState extends State<CheckHistoryForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  String regNo;
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
          buildRegNoFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Check History",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                showLoadingDialog(context);
                FirebaseFirestore.instance
                    .collection('Users')
                    .doc('$regNo@students.cuisahiwal.edu.pk')
                    .get()
                    .then((value) {
                  if (value.exists) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => History(regNo: regNo)));
                  } else {
                    Navigator.pop(context);
                    addError(error: 'Invalid Registeration Number');
                  }
                }).catchError((e) {
                  Navigator.pop(context);
                  addError(error: 'Invalid Registeration Number');
                });
              }
            },
          ),
        ]));
  }

  //////////////////////////////////////////////////////////////////////////////

  TextFormField buildRegNoFormField() {
    return TextFormField(
      onSaved: (newValue) => regNo = newValue.toLowerCase().trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: 'Enter Registertion Number');
          removeError(error: 'Invalid Registeration Number');
        }
        regNo = value.toLowerCase().trim();
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: 'Enter Registertion Number');
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        border: outlineBorder,
        labelText: "Reg No.",
        hintText: "Enter Registeration no.",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
