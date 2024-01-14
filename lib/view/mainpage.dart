import 'package:flutter/material.dart';
import 'package:instagram_demo/view/adddata.dart';
import 'package:instagram_demo/view/home.dart';
import 'package:instagram_demo/view/profile.dart';
import 'package:instagram_demo/view/reels.dart';
import 'package:instagram_demo/view/search.dart';
import 'package:instagram_demo/view_modal.dart/pagechangeprovider.dart';
import 'package:provider/provider.dart';

import '../utils/custum_icons_icons.dart';
import '../view_modal.dart/firebase_intraction.dart';
import '../view_modal.dart/theam_provider.dart';

class Botomnavigation extends StatefulWidget {
  const Botomnavigation({super.key});

  @override
  State<Botomnavigation> createState() => _BotomnavigationState();
}

class _BotomnavigationState extends State<Botomnavigation> {
  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    Themechange theme = Provider.of<Themechange>(context);
    final pages = Provider.of<Pagechange>(context);
    final firebase = Provider.of<FirebaseConnect>(context);
    return [
      BottomNavigationBarItem(
          icon: Icon(Custum_icons.home, color: theme.textcolor), label: ''),
      BottomNavigationBarItem(
          icon: Icon(
            Custum_icons.search,
            color: theme.textcolor,
          ),
          label: ''),
      BottomNavigationBarItem(
          icon: Icon(
            (Custum_icons.add_box),
            color: theme.textcolor,
          ),
          label: ''),
      BottomNavigationBarItem(
          icon: Icon(
            Custum_icons.instagram_reels_white_icon,
            color: theme.textcolor,
          ),
          label: ''),
      BottomNavigationBarItem(
          icon:
              CircleAvatar(backgroundImage: NetworkImage(firebase.downloadURL)),
          label: ''),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final pages = Provider.of<Pagechange>(context);

    const List<Widget> _pages = <Widget>[
      HomePage(),
      searchpage(),
      Adddata(),
      Reels(),
      profile(),
    ];

    Themechange theme = Provider.of<Themechange>(context);
    return Scaffold(
      body: _pages.elementAt(pages.bottomSelectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade900))),
        child: BottomNavigationBar(
          currentIndex: pages.bottomSelectedIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: theme.dark_baground,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: buildBottomNavBarItems(),
          selectedIconTheme: IconThemeData(opacity: 1),
          unselectedIconTheme: IconThemeData(opacity: 0.5),
          onTap: (value) => pages.pageChanged(value),
        ),
      ),
    );
  }
}
