import 'package:college_project/Screens/student_screens/event_screen.dart';
import 'package:college_project/Screens/student_screens/student_home_screen.dart';
import 'package:college_project/Screens/student_screens/student_profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class StudentBottomNavScreen extends StatefulWidget {
  @override
  State<StudentBottomNavScreen> createState() => _StudentBottomNavScreenState();
}

class _StudentBottomNavScreenState extends State<StudentBottomNavScreen> {
  @override
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<dynamic> _Screens = [
    const StudentHome(),
    const StudentEventScreen(),
    const StudentProfile()
  ];

  final List<Widget> screens = [
    const Icon(
      Icons.home_filled,
      size: 30,
      color: Color.fromRGBO(1, 37, 81, 1),
    ),
    const Icon(
      Icons.event,
      size: 30,
      color: Color.fromRGBO(1, 37, 81, 1),
    ),
    const Icon(
      Icons.account_circle_rounded,
      size: 30,
      color: Color.fromRGBO(1, 37, 81, 1),
    ),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        items: screens,
        height: 50,
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
