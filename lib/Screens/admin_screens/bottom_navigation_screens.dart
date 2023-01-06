import 'package:college_project/Screens/admin_screens/events_screen.dart';
import 'package:college_project/Screens/admin_screens/home_screen.dart';
import 'package:college_project/Screens/admin_screens/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class AdminBottomNavScreen extends StatefulWidget {
  @override
  State<AdminBottomNavScreen> createState() => _AdminBottomNavScreenState();
}

class _AdminBottomNavScreenState extends State<AdminBottomNavScreen> {
  @override
  int _selectedIndex = 0;

  final List<dynamic> _Screens = [
    AdminHomeScreen(),
    const EventsScreen(),
    ProfileScreen(),
  ];

  final List<Widget> screens = [
    const Icon(
      Icons.home_filled,
      size: 30,
      color: Color.fromRGBO(1,37,81,1),
    ),
    const Icon(
      Icons.event,
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
        color: Colors.white,
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
