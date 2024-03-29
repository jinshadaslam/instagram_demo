import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_demo/utils/custum_icons_icons.dart';
import 'package:instagram_demo/view/profilepages/posts.dart';
import 'package:provider/provider.dart';

import '../../utils/widgets.dart';
import '../../view_modal.dart/firebase_intraction.dart';
import '../../view_modal.dart/theam_provider.dart';
import '../add_profile_data.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Themechange theme = Provider.of<Themechange>(context);
    Widgets widgets = Widgets();
    final firebase = Provider.of<FirebaseConnect>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: theme.textcolor),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Add_profile_data()),
                );
              },
              child: Text('Edit profile'))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                profileimage(firebase),
                SizedBox(
                  width: 275,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            '45',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: theme.textcolor),
                          ),
                          Text(
                            'Posts',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: theme.textcolor),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '111',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: theme.textcolor),
                          ),
                          Text(
                            'Followers',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: theme.textcolor),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '75',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: theme.textcolor),
                          ),
                          Text(
                            'Following',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: theme.textcolor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  firebase.userdata!.fullName,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.textcolor),
                ),
                Text(
                  'Age:' + firebase.userdata!.age,
                  style: TextStyle(fontSize: 16, color: theme.textcolor),
                ),
              ],
            ),
          ),
          Expanded(child: TabBarDemo())
        ],
      ),
    );
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
                radius: 50,
                backgroundImage: NetworkImage(firebase.userdata!.url));
          }
        },
      );
    } else {
      return CircleAvatar(
          radius: 50, backgroundImage: NetworkImage(firebase.userdata!.url));
    }
  }
}

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Themechange theme = Provider.of<Themechange>(context);
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: TabBar(
            splashFactory: NoSplash.splashFactory,
            labelColor: theme.textcolor,
            indicatorColor: theme.textcolor,
            dividerColor: Colors.grey.shade800,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(icon: Icon(Icons.grid_on_sharp)),
              Tab(
                icon: Icon(
                  Custum_icons.instagram_reels_white_icon,
                  // color: theme.textcolor,
                ),
              ),
              Tab(icon: Icon(Icons.assignment_ind_outlined)),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: const TabBarView(
              children: [
                posts(),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
