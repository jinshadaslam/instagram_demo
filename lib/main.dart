import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_demo/view/add_profile_data.dart';
import 'package:instagram_demo/view_modal.dart/pagechangeprovider.dart';

import 'package:instagram_demo/view_modal.dart/theam_provider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
// import 'view/home.dart';
import 'view/login.dart';
import 'view/mainpage.dart';
import 'view_modal.dart/asses_gallary.dart';
import 'view_modal.dart/firebase_intraction.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => Themechange()),
    ChangeNotifierProvider(create: (context) => Pagechange()),
    ChangeNotifierProvider(create: (context) => Asses_gallary()),
    ChangeNotifierProvider(create: (context) => FirebaseConnect()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Themechange theme = Provider.of<Themechange>(context);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: theme.dark_baground,
        appBarTheme: AppBarTheme(backgroundColor: theme.dark_baground),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snap) {
            if (snap.data != null || snap.hasData) {
              return Botomnavigation();
            }
            return login_page();
          }),
    );
  }
}
