import 'package:flutter/material.dart';

import '../utils/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _searchpageState();
}

class _searchpageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    Widgets mywidgets = Widgets();
    return Scaffold(
      appBar: AppBar(
        title: mywidgets.mytext('searh page', context),
      ),
    );
  }
}
