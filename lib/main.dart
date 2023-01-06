import 'dart:async';
import 'package:college_project/Screens/accountant_screen/account_bottom_nav.dart';
import 'package:college_project/Screens/admin_screens/bottom_navigation_screens.dart';
import 'package:college_project/Screens/hod_screens/hod_bottom_nav.dart';
import 'package:college_project/Screens/student_screens/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  var check = pref.getString('token');
  var role = pref.getString('role');
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        checked: check,
        roles: role,
      ),
    ),
  );
}

class SplashScreen extends StatefulWidget {
  var checked;
  var roles;
  SplashScreen({
    required this.checked,
    required this.roles,
  });
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          PageTransition(
            duration: const Duration(milliseconds: 1000),
            type: PageTransitionType.fade,
            child: widget.roles == "superadmin"
                ? AdminBottomNavScreen()
                : widget.roles == "hod"
                    ? HodBottomNavScreen()
                    : widget.roles == "account"
                        ? AccountantBottomNavScreen()
                        : widget.roles == "student"
                            ? StudentBottomNavScreen()
                            : LoginScreen(),
            inheritTheme: true,
            ctx: context,
          ),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/logo.png',
            width: 100,
            height: 84,
          ),
          const SizedBox(
            height: 33,
          ),
          const Text(
            'Welcome \n       To',
            style: TextStyle(
              decoration: TextDecoration.none,
              height: 1.2,
              fontSize: 42,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Ralewaybold',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Image.asset(
            'images/aits.png',
            width: 200,
            height: 121,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
