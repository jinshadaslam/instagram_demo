import 'package:flutter/material.dart';

import 'package:instagram_demo/utils/widgets.dart';
import 'package:instagram_demo/utils/custum_icons_icons.dart';
import 'package:instagram_demo/view/login.dart';
import 'package:provider/provider.dart';
import '../view_modal.dart/theam_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widgets mywidgets = Widgets();
  @override
  @override
  Widget build(BuildContext context) {
    Themechange theme = Provider.of<Themechange>(context);

    return Scaffold(
      appBar: AppBar(
        title: mywidgets.mytext('instagram', context),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Custum_icons.hart,
              color: theme.textcolor,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Custum_icons.messenger,
              color: theme.textcolor,
            ),
          ),
          mywidgets.custom_switch(theme)
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
