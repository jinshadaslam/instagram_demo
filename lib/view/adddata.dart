import 'package:flutter/material.dart';

import '../utils/widgets.dart';

class Adddata extends StatefulWidget {
  const Adddata({super.key});

  @override
  State<Adddata> createState() => _AdddataState();
}

class _AdddataState extends State<Adddata> {
  Widgets mywidgets = Widgets();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: mywidgets.mytext('add data', context),
      ),
    );
  }
}
