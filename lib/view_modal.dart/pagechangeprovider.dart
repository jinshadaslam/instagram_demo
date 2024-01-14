import 'package:flutter/material.dart';

class Pagechange extends ChangeNotifier {
  int bottomSelectedIndex = 0;
  void pageChanged(int index) {
    bottomSelectedIndex = index;

    notifyListeners();
  }
}
