import 'package:flutter/material.dart';

class Themechange extends ChangeNotifier {
  bool darkmode = true;
  Color get dark_baground => darkmode ? Colors.black : Colors.white;
  Color get textcolor => darkmode ? Colors.white : Colors.black;
  Color get unselectcolor => darkmode
      ? Color.fromARGB(255, 61, 61, 61)
      : Color.fromARGB(255, 34, 33, 33);
  Color get textFieldborder => darkmode ? Colors.black : Colors.grey;
  Color get textfieldfill => darkmode
      ? Color.fromARGB(255, 44, 44, 44)
      : Color.fromARGB(255, 207, 205, 205);
  void changecolor(bool value) {
    darkmode = value;
    notifyListeners();
  }
}
