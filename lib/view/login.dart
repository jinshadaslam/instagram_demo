import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/widgets.dart';
import '../view_modal.dart/authentication.dart';
import '../view_modal.dart/theam_provider.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<login_page> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  Fire_auth firebase = Fire_auth();
  Widgets mywidgets = Widgets();
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<Themechange>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: Icon(Icons.person, color: theme.textcolor),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(60),
              //   border: Border.all(
              //     color: Colors.grey,
              //     width: 2.0,
              //   ),
              //   image: DecorationImage(
              //     image: AssetImage(
              //         'assets/instagram_logo.png'), // Replace with your own image
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ),
            SizedBox(height: 20),
            Text(
              'Iogin',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 280,
              child: mywidgets.textfield(
                  theme: theme, textEditer: username, labeltext: 'username'),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 280,
              child: mywidgets.textfield(
                  theme: theme, textEditer: username, labeltext: 'password'),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 280,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, 'HomePage'); // Add your login logic here
                },
                child: Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Add your password recovery logic here
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                mywidgets.mytext("Don't have an account?", context),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'SignupPage');
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () async {
                await firebase.signInWithGoogle(context);
              },
              icon: Icon(Icons.g_mobiledata, color: theme.textcolor),
            )
          ],
        ),
      ),
    );
  }
}
