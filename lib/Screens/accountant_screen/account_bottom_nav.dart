import 'package:college_project/Screens/accountant_screen/account_profile.dart';
import 'package:college_project/Screens/accountant_screen/accountant_home.dart';
import 'package:college_project/Screens/hod_screens/hod_events.dart';
import 'package:college_project/Screens/hod_screens/hod_home_screen.dart';
import 'package:college_project/Screens/hod_screens/hod_profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class AccountantBottomNavScreen extends StatefulWidget {
  @override
  State<AccountantBottomNavScreen> createState() => _AccountantBottomNavScreenState();
}

class _AccountantBottomNavScreenState extends State<AccountantBottomNavScreen> {
  @override
  int _selectedIndex = 0;

  final List<dynamic> _Screens = [
  AccountantHomeScreen(),
    AccountantProfileScreen(),
  ];

  final List<Widget> screens = [
    const Icon(
      Icons.home_filled,
      size: 30,
      color: Color.fromRGBO(1,37,81,1),
    ),
    const Icon(
      Icons.account_circle_rounded,
      size: 30,
      color: Color.fromRGBO(1,37,81,1),
    ),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        color:Color.fromRGBO(244, 244, 247, 1),
        items: screens,
        height: 70,
        index: _selectedIndex,
        onTap: (indexes) {
          setState(() {
            this._selectedIndex = indexes;
          });
        },
        buttonBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,

      ),
      body: _Screens[_selectedIndex],
    );
  }
}
