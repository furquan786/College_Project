import 'dart:convert';
import 'package:college_project/Screens/admin_screens/admin_login_screen.dart';
import 'package:college_project/Screens/student_screens/bottom_nav.dart';
import 'package:college_project/sign_up_screens/scholar_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController mnocontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  late AssetImage assetImage;

  var studenttoken;
  var role;
  var studentid;

  Future<void> studentlogin(String email, String password, String mno) async {
    try {
      var req = new Map();
      if (mno.length == 10) {
        req['mno'] = int.parse(mno);
      } else if (email.length > 0) {
        req['email'] = email;
      }
      req['password'] = password;
      var response = await http.post(
          Uri.parse('https://aitsudaipur.herokuapp.com/api/student/signin'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode(req));
      var data = jsonDecode(response.body);
      // print("data is going ${data}");
      Map<String, dynamic> studentdata = jsonDecode(response.body);
      studenttoken = studentdata['token'];
      studentid = studentdata['user']['_id'];
      role = studentdata['user']['role'];
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        preferences.setString('stoken', studenttoken);
        preferences.setString('sid', studentid);
        preferences.setString('role', role);
      });
      if (response.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                type: PageTransitionType.topToBottom,
                child: StudentBottomNavScreen(),
                inheritTheme: true,
                ctx: context),
            (route) => false);
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
                "${data}".replaceRange(0, 7, '').replaceAll(
                      '}',
                      '',
                    ),
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
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), side: BorderSide.none),
            title: const Text(
              "Oops!",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.black,
                height: 1.5,
              ),
            ),
            content: const Text(
              "Invalid Id and Password",
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
        },
      );

      setState(() {
        saving = false;
      });
      print("an exception occur ${e}");
    }
  }

  @override
  void initState() {
    assetImage = AssetImage('images/login.jpg');

    super.initState();
  }

  bool saving = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(39, 76, 120, 1),
            Color.fromRGBO(20, 38, 60, 1),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: ModalProgressHUD(
            inAsyncCall: saving,
            child: Container(
              margin: EdgeInsets.all(25),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Login',
                            style: boldtexstyle,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScholarScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                  fontFamily: 'Montserratbold',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text('Email', style: loginlightfont),
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.only(bottom: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 8,
                              offset: Offset(5, 5),
                            ),
                          ],
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
                            return "please enter valid email/MobileNumber";
                          },
                          // controller: scholarcontroller,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              fontFamily: 'Poppinslight',
                            ),
                            contentPadding:
                                EdgeInsets.only(left: 14, top: 10, bottom: 6),
                            border: InputBorder.none,
                            hintText: 'Email or Mobile no.',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(196, 196, 196, 1),
                                fontSize: 14,
                                fontFamily: 'Montserratmediium',
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Password',
                            style: loginlightfont,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(29, 0, 46, 1),
                              blurRadius: 8,
                              offset: Offset(5, 5),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: passwordcontroller,
                          validator: (val) {
                            return val!.length < 8
                                ? "Enter Password 8 Character"
                                : null;
                          },
                          // controller: scholarcontroller,
                          decoration: const InputDecoration(
                            errorStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 10,
                              fontFamily: 'Poppinslight',
                            ),
                            contentPadding:
                                EdgeInsets.only(left: 14, top: 10, bottom: 6),
                            border: InputBorder.none,
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(196, 196, 196, 1),
                                fontSize: 14,
                                fontFamily: 'Montserratmediium',
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              saving = true;
                            });
                            try {
                              studentlogin(
                                emailcontroller.text,
                                passwordcontroller.text,
                                mnocontroller.text,
                              );
                            } catch (e) {
                              print("execption in api calls ${e}");
                              setState(() {
                                saving = false;
                              });
                            }
                          }
                        },
                        child: Container(
                          height: 55,
                          width: 800,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: Color.fromRGBO(42, 54, 78, 1),
                          ),
                          child: const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Montserratbold',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.topToBottom,
                                child: AdminLoginScreen(),
                                inheritTheme: true,
                                ctx: context),
                          );
                        },
                        child: const Text(
                          'Login as Admin / Faculty / Accountant',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontFamily: 'Poppinsbold',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Center(
                        child: Text(
                          'By continuing, you agree to accept our',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppinsmedium',
                              fontWeight: FontWeight.normal,
                              fontSize: 10),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Center(
                        child: Text(
                          'Privacy Policy & Terms of Service',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppinsmedium',
                              fontWeight: FontWeight.normal,
                              fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
