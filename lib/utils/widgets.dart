import 'package:flutter/material.dart';
// import 'dart:js';
import 'package:provider/provider.dart';

import '../view_modal.dart/theam_provider.dart';

class Widgets {
  Widget mytext(String text, BuildContext context) {
    Themechange theme = Provider.of<Themechange>(
      context,
    );
    return Text(
      text,
      style: TextStyle(color: theme.textcolor),
    );
  }

  Switch custom_switch(Themechange theme) {
    return Switch(
      value: theme.darkmode,
      onChanged: (value) {
        theme.changecolor(value);
      },
    );
  }

  SizedBox textfield(
      {required Themechange theme,
      required TextEditingController textEditer,
      required String labeltext}) {
    return SizedBox(
      height: 50,
      width: 350,
      child: TextField(
        controller: textEditer,
        style: TextStyle(color: theme.textcolor),
        cursorColor: theme.textcolor,
        decoration: InputDecoration(
          filled: true,
          fillColor: theme.textfieldfill,
          //
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.textFieldborder),
              borderRadius: BorderRadius.circular(6)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.textFieldborder),
              borderRadius: BorderRadius.circular(6)),
          hintText: labeltext,
          hintStyle: TextStyle(
            color: theme.textcolor,
          ),
        ),
      ),
    );
  }
}