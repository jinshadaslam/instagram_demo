import 'package:flutter/material.dart';

import '../utils/widgets.dart';

class Reels extends StatefulWidget {
  const Reels({super.key});

  @override
  State<Reels> createState() => _ReelsState();
}

class _ReelsState extends State<Reels> {
  @override
  Widget build(BuildContext context) {
    Widgets mywidgets = Widgets();
    return Scaffold(
      appBar: AppBar(
        title: mywidgets.mytext('reels', context),
      ),
    );
  }
}
