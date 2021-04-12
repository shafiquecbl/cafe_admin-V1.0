import 'package:flutter/material.dart';

customAppBar(
  text,
) {
  AppBar appBar = AppBar(
    elevation: 2,
    centerTitle: false,
    title: Padding(
      padding: const EdgeInsets.only(left: 0),
      child: Text(
        '$text',
      ),
    ),
  );
  return appBar;
}
