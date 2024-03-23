import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_demo/view/adddata.dart';
import 'package:instagram_demo/view/home.dart';
import 'package:instagram_demo/view/profilepages/profile.dart';
import 'package:instagram_demo/view/reels.dart';
import 'package:instagram_demo/view/search.dart';
import 'package:instagram_demo/view_modal.dart/pagechangeprovider.dart';
import 'package:provider/provider.dart';
import '../utils/custum_icons_icons.dart';
import '../view_modal.dart/firebase_intraction.dart';
import '../view_modal.dart/theam_provider.dart';

class Botomnavigation extends StatelessWidget {
  const Botomnavigation({Key? key}) : super(key: key);

  List<BottomNavigationBarItem> buildBottomNavBarItems(
      FirebaseConnect firebase, Themechange theme) {
    return [
      BottomNavigationBarItem(
        icon: Icon(Custum_icons.home, color: theme.textcolor),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Custum_icons.search, color: theme.textcolor),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add_box_outlined, color: theme.textcolor),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Custum_icons.instagram_reels_white_icon,
            color: theme.textcolor),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: profileimage(firebase),
        label: '',
      ),
    ];
  }

  Widget profileimage(FirebaseConnect firebase) {
    if (firebase.userdata?.url == null) {
      return FutureBuilder(
        future: firebase.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(firebase.userdata!.url),
            );
          }
        },
      );
    } else {
      return CircleAvatar(
        radius: 12,
        backgroundImage: NetworkImage(firebase.userdata!.url),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('agggggggan');
    final pages = Provider.of<Pagechange>(context);
    final firebase = Provider.of<FirebaseConnect>(context);
    final theme = Provider.of<Themechange>(context);
    int currentScreenIndex = pages.fetchCurrentScreenIndex;
    const List<Widget> _pages = <Widget>[
      HomePage(),
      SearchPage(),
      AddData(),
      Reels(),
      ProfilePage(),
    ];

    return Scaffold(
      body: _pages[currentScreenIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade900)),
        ),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: currentScreenIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: theme.dark_baground,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: buildBottomNavBarItems(firebase, theme),
            selectedIconTheme: const IconThemeData(opacity: 1),
            unselectedIconTheme: const IconThemeData(opacity: 0.5),
            onTap: (value) => pages.pageChanged(value),
            enableFeedback: false,
          ),
        ),
      ),
    );
  }
}
