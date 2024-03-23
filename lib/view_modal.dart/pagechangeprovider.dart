import 'package:flutter/material.dart';

class Pagechange extends ChangeNotifier {
  int bottomSelectedIndex = 0;
  int get fetchCurrentScreenIndex {
    return bottomSelectedIndex;
  }

  void pageChanged(int index) {
    bottomSelectedIndex = index;

    notifyListeners();
  }
}
