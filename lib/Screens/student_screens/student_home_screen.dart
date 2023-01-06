import 'package:college_project/Screens/student_screens/schedule_screen.dart';
import 'package:college_project/Screens/student_screens/student_all_details.dart';
import 'package:college_project/Screens/student_screens/student_attendance.dart';
import 'package:college_project/Screens/student_screens/student_fee.dart';
import 'package:college_project/Screens/student_screens/student_notice_list.dart';
import 'package:college_project/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  void initState() {
    this.getstudentidtoken();
    super.initState();
  }

  var studenttoken;
  var studentid;
  Future<void> getstudentidtoken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      studenttoken = pref.getString('stoken');
      studentid = pref.getString('sid');
    });
    print("student id is $studentid");
    print("token is $studenttoken");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(top: 40),
          child: Text(
            'Home',
            style: TextStyle(
              fontSize: 22,
              letterSpacing: 1.6,
              color: Colors.white,
              fontFamily: 'Ralewaybold',
            ),
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: SizedBox(),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/appbg2.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Container(
        width: 700,
        height: double.maxFinite,
        child: GridView(
          padding: EdgeInsets.only(top: 20, right: 8, left: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
          children: [
            studenthome(FontAwesomeIcons.addressCard, 'Students', () {
              Navigator.push(
                context,
                PageTransition(
                  curve: Curves.bounceOut,
                  child: StudentAllDetail(
                    studentid: studentid,
                    studenttoken: studenttoken,
                  ),
                  type: PageTransitionType.bottomToTop,
                ),
              );
            }),
            studenthome(FontAwesomeIcons.indianRupeeSign, 'Fees', () {
              Navigator.push(
                context,
                PageTransition(
                    child: StudentFees(), type: PageTransitionType.fade),
              );
            }),
            studenthome(
              FontAwesomeIcons.calendarDay,
              'Class\nRoutine',
              () {
                Navigator.push(
                  context,
                  PageTransition(
                      child: StudentSchedule(),
                      type: PageTransitionType.leftToRight),
                );
              },
            ),
            studenthome(FontAwesomeIcons.bookOpen, 'HomeWork', () {}),
            studenthome(FontAwesomeIcons.clipboardUser, 'Attendance', () {
              Navigator.push(
                context,
                PageTransition(
                    child: StudentAttendance(),
                    type: PageTransitionType.bottomToTop),
              );
            }),
            studenthome(FontAwesomeIcons.shapes, 'Exams', () {}),
            studenthome(FontAwesomeIcons.circleExclamation, 'Notices', () {
              Navigator.push(
                context,
                PageTransition(
                  child: StudentNoticesList(
                    studentid: studentid,
                    studenttoken: studenttoken,
                  ),
                  type: PageTransitionType.rightToLeft,
                ),
              );
            }),
            studenthome(FontAwesomeIcons.book, 'Subject', () {}),
            studenthome(FontAwesomeIcons.person, 'Teachers', () {}),
            studenthome(FontAwesomeIcons.car, 'Transport', () {}),
            studenthome(FontAwesomeIcons.building, 'Hostels', () {}),
          ],
        ),
      ),
    );
  }
}
