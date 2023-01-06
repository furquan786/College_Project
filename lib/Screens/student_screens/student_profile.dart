import 'package:college_project/Screens/login_screen.dart';
import 'package:college_project/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 18,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Profile",
          style: TextStyle(
            fontFamily: 'Montserratbold',
            fontSize: 19,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(249, 251, 255, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 19,
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(175, 241, 255, 1),
              radius: 60,
              child: CircleAvatar(
                radius: 55,
                backgroundImage: AssetImage('images/profile2.png'),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            'Student Name',
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontFamily: 'Montserratbold',
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1),
          ),
          const SizedBox(
            height: 2,
          ),
          const Text(
            'B-tech CSE',
            style: TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(188, 188, 188, 1),
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppinsmedium',
                letterSpacing: 1.1),
          ),
          const SizedBox(
            height: 61,
          ),
          Container(
            padding: const EdgeInsets.only(left: 31, right: 20),
            height: 360,
            width: 370,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(44),
                topRight: Radius.circular(44),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 64,
                ),
                studentprofile(FontAwesomeIcons.idCard, "Personal Info"),
                const SizedBox(
                  height: 24,
                ),
                studentprofile(Icons.settings, "Setting"),
                const SizedBox(
                  height: 24,
                ),
                studentprofile(Icons.account_box, "Acccount info"),
                const SizedBox(
                  height: 24,
                ),
                studentprofile(Icons.cast_connected, "Privacy"),
                const SizedBox(
                  height: 24,
                ),
                studentprofile(FontAwesomeIcons.question, "About"),
                const SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.clear();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Sign Out',
                    style: TextStyle(
                      fontFamily: 'Poppinsbold',
                      fontSize: 16,
                      color: Color.fromRGBO(99, 99, 99, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
