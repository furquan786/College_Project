import 'package:college_project/Screens/admin_screens/create_faculty.dart';
import 'package:college_project/Screens/admin_screens/send_notice.dart';
import 'package:college_project/Screens/login_screen.dart';
import 'package:college_project/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    isloading = true;
    getdetails();
    Future.delayed(
      Duration(seconds: 2),
    ).whenComplete(() {
      setState(() {
        isloading = false;
      });
    });
    print("name is coming ${firstname}");
    super.initState();
  }

  late bool isloading;

  var firstname;
  var lastname;
  var email;
  var mno;
  var admintoken;
  var adminid;

  Future<void> getdetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      firstname = pref.getString('fname');
      lastname = pref.getString('lname');
      email = pref.getString('email');
      mno = pref.getInt('mno');
      admintoken = pref.getString('token');
      adminid = pref.getString('id');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            height: MediaQuery.of(context).size.height,
            child: isloading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2.6,
                      ),
                      Adminprofiledata(
                        FontAwesomeIcons.user,
                        (firstname + ' ' + lastname).toUpperCase(),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Adminprofiledata(
                        Icons.mail_outline,
                        email,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Adminprofiledata(
                          FontAwesomeIcons.circleExclamation, "About"),
                      const SizedBox(
                        height: 8,
                      ),
                      Adminprofiledata(Icons.event_available, "Old Events"),
                      const SizedBox(
                        height: 8,
                      ),
                      Adminprofiledata(
                          FontAwesomeIcons.contactBook, mno.toString()),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, top: 15),
                        child: GestureDetector(
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
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                size: 26,
                                color: Colors.blueGrey.shade600,
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              const Expanded(
                                child: Text(
                                  'LogOut',
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.clip,
                                  softWrap: false,
                                  style: TextStyle(
                                    // overflow: TextOverflow.ellipsis,
                                    fontFamily: 'Montserratbold',
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.black,
                                    decorationStyle: TextDecorationStyle.solid,
                                    decorationThickness: 1.4,
                                    wordSpacing: 1.2,
                                    letterSpacing: 1.3,
                                    color: Colors.black87,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 2,
                        width: MediaQuery.of(context).size.width / 1.2,
                        color: Colors.blueGrey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateFaculty(),
                                ),
                              );
                            },
                            child: Container(
                              height: 40,
                              width: 140,
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(1, 37, 81, 1),
                                    blurRadius: 4,
                                    offset: Offset(
                                      5,
                                      5,
                                    ),
                                  ),
                                ],
                                color: Color.fromRGBO(1, 37, 81, 1),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Create Faculty',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    fontFamily: 'Montserratbold',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SendNotices(
                                    getadminid: adminid,
                                    getadmintoken: admintoken,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 40,
                              width: 140,
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(1, 37, 81, 1),
                                    blurRadius: 4,
                                    offset: Offset(
                                      5,
                                      5,
                                    ),
                                  ),
                                ],
                                color: Color.fromRGBO(1, 37, 81, 1),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Send Notice',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    fontFamily: 'Montserratbold',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
          ),
          Positioned(
            left: 240,
            top: 70,
            child: Container(
              height: 210,
              width: 230,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color.fromRGBO(34, 63, 96, 1)),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2.7,
            width: MediaQuery.of(context).size.width / 1.0001,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.elliptical(580, 130),
              ),
              color: Color.fromRGBO(19, 23, 34, 1),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3.28,
            width: MediaQuery.of(context).size.width / 1.0001,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.elliptical(390, 200),
                bottomLeft: Radius.elliptical(
                  350,
                  70,
                ),
              ),
              color: Color.fromRGBO(37, 76, 123, 1),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3.8,
            width: MediaQuery.of(context).size.width / 1.0001,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.elliptical(330, 250),
                bottomLeft: Radius.elliptical(
                  400,
                  190,
                ),
              ),
              color: Colors.white,
            ),
          ),
          Center(
            child: Column(
              children: const [
                SizedBox(height: 40),
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(1, 37, 81, 1),
                  radius: 50,
                  child: CircleAvatar(
                    radius: 44,
                    backgroundImage: AssetImage('images/profile.png'),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Hemant Dabai',
                  style: TextStyle(
                    fontFamily: 'Poppinsbold',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromRGBO(1, 37, 81, 1),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
