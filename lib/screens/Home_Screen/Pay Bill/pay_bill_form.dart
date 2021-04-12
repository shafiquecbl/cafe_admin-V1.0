import 'package:flutter/material.dart';
import 'package:cafe_admin/components/custom_surfix_icon.dart';
import 'package:cafe_admin/components/default_button.dart';
import 'package:cafe_admin/components/form_error.dart';
import 'package:cafe_admin/size_config.dart';
import 'package:cafe_admin/widgets/alert_dialog.dart';
import 'package:cafe_admin/widgets/outline_input_border.dart';
import 'package:cafe_admin/models/setData.dart';

class PayBillForm extends StatefulWidget {
  @override
  _PayBillFormState createState() => _PayBillFormState();
}

class _PayBillFormState extends State<PayBillForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  int amount;
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
          buildAmountFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Pay Bill",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                showLoadingDialog(context);
                payBill(context: context, regNo: regNo, amount: amount);
              }
            },
          ),
        ]));
  }
  //////////////////////////////////////////////////////////////////////////////

  TextFormField buildAmountFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => amount = int.parse(newValue),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: 'Add Amount');
        }
        amount = int.parse(value);
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: 'Add Amount');
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        border: outlineBorder,
        labelText: "Amount",
        hintText: "Enter Amount",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.attach_money_outlined),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////

  TextFormField buildRegNoFormField() {
    return TextFormField(
      onSaved: (newValue) => regNo = newValue.toLowerCase().trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: 'Add Registeration No');
        }
        regNo = value.toLowerCase().trim();
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: 'Add Registeration No');
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        border: outlineBorder,
        labelText: "RegNo",
        hintText: "Enter Registerion Number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  payBill({context, @required regNo, @required amount}) {
    SetData().payBill(context: context, regNo: regNo, amount: amount);
  }
}
