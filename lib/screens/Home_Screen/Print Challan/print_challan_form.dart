import 'package:cafe_admin/screens/Home_Screen/Print%20Challan/pdf.dart';
import 'package:flutter/material.dart';
import 'package:cafe_admin/components/custom_surfix_icon.dart';
import 'package:cafe_admin/components/default_button.dart';
import 'package:cafe_admin/components/form_error.dart';
import 'package:cafe_admin/size_config.dart';
import 'package:cafe_admin/widgets/outline_input_border.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PrintChallanForm extends StatefulWidget {
  @override
  _PrintChallanFormState createState() => _PrintChallanFormState();
}

class _PrintChallanFormState extends State<PrintChallanForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  int amount;
  String regNo;

  ///////
  final pdf = pw.Document();
  final PdfColor baseColor = PdfColors.teal;
  final PdfColor accentColor = PdfColors.blueGrey900;
  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;

  PdfColor get _accentTextColor =>
      baseColor.luminance < 0.5 ? _lightColor : _darkColor;
  ///////

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

  writeOnPdf() {
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a5,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          _buildHeader(context),
          _contentHeader(context),
        ];
      },
    ));
  }

  Future savePdf() async {
    List<Directory> documentDirectory = await getExternalStorageDirectories();
    String dir = documentDirectory.first.path;

    final file = File("$dir/example.pdf");

    file.writeAsBytesSync(await pdf.save());
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
            text: "Submit",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                writeOnPdf();
                await savePdf();

                List<Directory> documentDirectory =
                    await getExternalStorageDirectories();
                String dir = documentDirectory.first.path;
                String fullPath = "$dir/example.pdf";

                print(fullPath);

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PdfPreviewScreen(
                              pdf: pdf,
                              path: fullPath,
                            )));
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
        suffixIcon: Icon(Icons.money_rounded),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////

  TextFormField buildRegNoFormField() {
    return TextFormField(
      onSaved: (newValue) => regNo = newValue.toUpperCase().trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: 'Add Registeration No');
        }
        regNo = value.toUpperCase().trim();
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

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Column(
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(vertical: 10),
          alignment: pw.Alignment.center,
          child: pw.Text(
            'CUI Sahiwal Campus',
            style: pw.TextStyle(
              color: PdfColors.blue,
              fontWeight: pw.FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ),
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(vertical: 10),
          alignment: pw.Alignment.center,
          child: pw.Text(
            'INVOICE',
            style: pw.TextStyle(
              color: baseColor,
              fontWeight: pw.FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
        pw.Container(
          decoration: pw.BoxDecoration(
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
            color: accentColor,
          ),
          padding: const pw.EdgeInsets.only(
              left: 40, top: 10, bottom: 10, right: 20),
          alignment: pw.Alignment.centerLeft,
          height: 50,
          child: pw.DefaultTextStyle(
            style: pw.TextStyle(
              color: _accentTextColor,
              fontSize: 12,
            ),
            child: pw.GridView(
              crossAxisCount: 2,
              children: [
                pw.Text('Reg #'),
                pw.Text(regNo.toUpperCase()),
                pw.Text('Date:'),
                pw.Text(_formatDate(DateTime.now())),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final format = DateFormat.yMMMd('en_US');
    return format.format(date);
  }

  pw.Widget _contentHeader(pw.Context context) {
    return pw.Column(
      children: [
        pw.Container(
          margin: const pw.EdgeInsets.symmetric(vertical: 15),
          alignment: pw.Alignment.center,
          child: pw.Text(
            'Invoice to: ${regNo.toUpperCase()}',
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        pw.Container(
          child: pw.Text(
            'Total: Rs.$amount',
            style: pw.TextStyle(
                color: baseColor, fontWeight: pw.FontWeight.bold, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
