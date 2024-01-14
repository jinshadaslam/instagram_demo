import 'package:flutter/material.dart';

import '../utils/widgets.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  Widgets mywidgets = Widgets();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: mywidgets.mytext('profile', context)),
    );
  }
}
