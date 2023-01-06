import 'dart:convert';
import 'package:college_project/Screens/accountant_screen/accountant_home.dart';
import 'package:college_project/Screens/admin_screens/bottom_navigation_screens.dart';
import 'package:college_project/Screens/hod_screens/hod_bottom_nav.dart';
import 'package:college_project/Screens/hod_screens/hod_home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../accountant_screen/account_bottom_nav.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  bool saving = false;
  int? valuuss;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController mnocontroller = TextEditingController();
  var token;
  var id;
  var fname;
  var lname;
  var mnos;
  var emails;
  var role;
  var department;

  Future<void> adminlogin(String email, String password, String mno) async {
    try {
      var req = new Map();
      if (email.length > 0) {
        req['email'] = email;
      } else if (mno.length == 10) {
        req['mno'] = int.parse(mno);
      }
      req['password'] = password;
      var response = await http.post(
          Uri.parse("https://aitsudaipur.herokuapp.com/api/faculty/signin"),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode(req));
      var data = jsonEncode(response.body);
      Map<String, dynamic> admindata = jsonDecode(response.body);
      token = admindata['token'];
      id = admindata['user']['_id'];
      emails = admindata['user']['email'];
      mnos = admindata['user']['mno'];
      fname = admindata['user']['first_name'];
      lname = admindata['user']['last_name'];
      role = admindata['user']['role'];
      department = admindata['user']['department'];
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        preferences.setString('token', token);
        preferences.setString('id', id);
        preferences.setString('fname', fname);
        preferences.setString('lname', lname);
        preferences.setString('email', emails);
        preferences.setInt('mno', mnos);
        preferences.setString('role', role);
        preferences.setString('department', department);
      });
      if (response.statusCode == 200) {
        if (data.contains("superadmin")) {
          Navigator.of(context).pushAndRemoveUntil(
              PageTransition(
                  duration: const Duration(milliseconds: 600),
                  reverseDuration: const Duration(milliseconds: 600),
                  type: PageTransitionType.scale,
                  alignment: Alignment.center,
                  child: AdminBottomNavScreen(),
                  inheritTheme: true,
                  ctx: context),
              (Route<dynamic> route) => false);
        } else if (data.contains('hod')) {
          Navigator.of(context).pushAndRemoveUntil(
              PageTransition(
                  duration: const Duration(milliseconds: 600),
                  reverseDuration: const Duration(milliseconds: 600),
                  type: PageTransitionType.scale,
                  alignment: Alignment.center,
                  child: HodBottomNavScreen(),
                  inheritTheme: true,
                  ctx: context),
              (Route<dynamic> route) => false);
        } else if (data.contains('account')) {
          Navigator.of(context).pushAndRemoveUntil(
              PageTransition(
                  duration: const Duration(milliseconds: 600),
                  reverseDuration: const Duration(milliseconds: 600),
                  type: PageTransitionType.scale,
                  alignment: Alignment.center,
                  child: AccountantBottomNavScreen(),
                  inheritTheme: true,
                  ctx: context),
              (Route<dynamic> route) => false);
        }
      } else {
        setState(() {
          saving = false;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide.none),
                title: const Text(
                  "Oops!",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    height: 1.5,
                  ),
                ),
                content: Text(
                  data
                      .replaceRange(0, 10, '')
                      .replaceAll('}', '')
                      .replaceAll('"', "")
                      .replaceAll('/', '')
                      .replaceAll(':', '')
                      .replaceAll(r'\', ''),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                actions: [
                  TextButton(
                    child: const Text(
                      "Ok",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide.none),
              title: const Text(
                "Oops!",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
              content: const Text(
                "Please provide a valid email id and password",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              actions: [
                TextButton(
                  child: const Text(
                    "Ok",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });

      print(e);
      setState(() {
        saving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: saving,
          progressIndicator: CircularProgressIndicator(
            color: Colors.black,
          ),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 330,
                  child: Stack(
                    children: [
                      Positioned(
                        width: width,
                        height: 338,
                        top: -28.7,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/projectbg1.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        height: 330,
                        width: width + 70,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/projectbg.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                            color: Color.fromRGBO(49, 39, 79, 1),
                            fontFamily: 'Montserratbold',
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.4,
                            fontSize: 30),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: formKey,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                child: TextFormField(
                                  validator: (val) {
                                    if (RegExp(r"(0|91)?[7-9][0-9]{9}")
                                        .hasMatch(val!)) {
                                      mnocontroller.text = val;
                                      return null;
                                    } else if (RegExp(
                                            r"[a-zA-Z0-9.! #$%&'*+/=? ^_`{|}~-]+@[a-zA-Z0-9-]")
                                        .hasMatch(val)) {
                                      emailcontroller.text = val;
                                      return null;
                                    }
                                    return "please enter valid email/mno";
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Email or Mob.no.',
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade900,
                                      fontFamily: 'Poppinslight',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: passwordcontroller,
                                  validator: (val) {
                                    return val!.length < 8
                                        ? "Enter Password 8+ Character"
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade900,
                                      fontFamily: 'Poppinslight',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          // create a method of forgot password
                        },
                        child: const Center(
                          child: Text(
                            'ForgetPassword?',
                            style: TextStyle(
                              fontFamily: 'Montserratmediium',
                              fontWeight: FontWeight.w300,
                              color: Color.fromRGBO(1, 37, 81, 1),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              saving = true;
                            });
                            try {
                              adminlogin(
                                emailcontroller.text,
                                passwordcontroller.text,
                                mnocontroller.text,
                              );
                            } catch (e) {
                              setState(() {
                                saving = false;
                              });
                              print("${e} errro on callin method");
                            }
                          }
                        },
                        child: Container(
                          height: 60,
                          margin: const EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color.fromRGBO(49, 39, 79, 1),
                          ),
                          child: const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontFamily: 'Montserratbold',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
