import 'dart:convert';
import 'package:college_project/sign_up_screens/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({required this.data});
  var data;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late String name;
  late String lastname;
  late String course;
  late String email;
  late String id;
  TextEditingController mobilenumbercontroller = TextEditingController();
  TextEditingController pascontroller = TextEditingController();
  @override
  void initState() {
    getdata(widget.data);
    super.initState();
  }

  var token;

  void getdata(Map<String, dynamic> sdata) {
    setState(() {
      try {
        if (sdata == null) {
          name = 'Nullgq';
          course = 'Nullww';
          email = 'Nullww';
        }
        name = sdata['student']['first_name'];
        lastname = sdata['student']['last_name'];
        email = sdata['student']['email'];
        course = sdata['student']['course'];
        id = sdata['student']['_id'];
      } catch (e) {
        print("heelloooo ${e}");
      }
    });
  }

  Future<void> postdetail(String mno, String pass) async {
    var req = new Map();
    req['mno'] = int.parse(mno);
    req['password'] = pass;
    req['id'] = id;
    var response = await http.post(
        Uri.parse(
            "https://aitsudaipur.herokuapp.com/api/signup/student/sendotp"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(req));
    var data = response.body;
    token = jsonDecode(data);
    print("data is comiing ${data}");
    if (response.statusCode == 200) {
      setState(() {
        saving = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPVerification(
            otptoken: token,
          ),
        ),
      );
      return token;
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
                style: const TextStyle(
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
  }

  bool saving = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(25, 48, 76, 1),
        automaticallyImplyLeading: true,
        title: const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 22,
              letterSpacing: 1.6,
              color: Colors.white,
              fontFamily: 'Montserratbold',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: SizedBox(),
        ),
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: saving,
          child: Container(
            margin: const EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Step 2 of 3'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserratmediium',
                          color: Color.fromRGBO(1, 37, 81, 1),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 66, top: 9),
                    child: Text(
                      'Enter your personal info?',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontFamily: 'Montserratbold',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formKey,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(1, 37, 81, 1),
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ]),
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(left: 14, top: 6),
                                border: InputBorder.none,
                                hintText: ' ${name + " " + lastname} ',
                                hintStyle: TextStyle(
                                    color: Colors.blueGrey.shade600,
                                    fontFamily: 'Poppinsmedium',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 5),
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(1, 37, 81, 1),
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ]),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (val) {
                                return val!.length < 10 || val.length > 10
                                    ? "Enter Mobile Number 10 Character"
                                    : null;
                              },
                              controller: mobilenumbercontroller,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                    fontFamily: 'Poppinslight',
                                    fontWeight: FontWeight.w500),
                                contentPadding: const EdgeInsets.only(
                                  left: 14,
                                  top: 9,
                                  bottom: 3,
                                ),
                                border: InputBorder.none,
                                hintText: 'Enter-Mobile Number',
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade900,
                                  fontFamily: 'Poppinsmedium',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(1, 37, 81, 1),
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ]),
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(left: 14, top: 6),
                                border: InputBorder.none,
                                hintText: '${email}',
                                hintStyle: TextStyle(
                                    color: Colors.blueGrey.shade600,
                                    fontFamily: 'Poppinsmedium',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(1, 37, 81, 1),
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ]),
                            child: TextFormField(
                              readOnly: true,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(left: 14, top: 6),
                                border: InputBorder.none,
                                hintText: '${course}',
                                hintStyle: TextStyle(
                                    color: Colors.blueGrey.shade600,
                                    fontFamily: 'Poppinsmedium',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 6),
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(1, 37, 81, 1),
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ]),
                            child: TextFormField(
                              validator: (val) {
                                return val!.length < 8
                                    ? "Enter password at least 8 Character"
                                    : null;
                              },
                              controller: pascontroller,
                              decoration: InputDecoration(
                                errorStyle: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontFamily: 'Poppinslight',
                                  fontWeight: FontWeight.w500,
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 14, top: 6, bottom: 3),
                                border: InputBorder.none,
                                hintText: 'Enter-Password',
                                hintStyle: TextStyle(
                                    color: Colors.grey.shade900,
                                    fontFamily: 'Poppinsmedium',
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  saving = true;
                                });
                                try {
                                  postdetail(mobilenumbercontroller.text,
                                      pascontroller.text);
                                } catch (e) {
                                  print("execption in api calls ${e}");
                                  setState(() {
                                    saving = false;
                                  });
                                }
                              }
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              height: 45,
                              width: 700,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                color: Color.fromRGBO(1, 37, 81, 1),
                              ),
                              child: const Center(
                                child: Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Montserratbold',
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.4,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Container(
//   margin: EdgeInsets.only(
//       left: 10,right: 10
//   ),
//   height: 50,
//   decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(10),
//       boxShadow: const [
//         BoxShadow(
//           color: Color.fromRGBO(29, 0, 46, 1),
//           blurRadius: 5,
//           offset: Offset(1,2),
//         ),
//       ]),
//   child: TextFormField(
//     decoration: const InputDecoration(
//       contentPadding: EdgeInsets.only(left: 14, top: 6),
//       border: InputBorder.none,
//       hintText: 'Branch',
//       hintStyle: TextStyle(
//         color: Colors.grey,
//       ),
//     ),
//   ),
// ),
// const SizedBox(
//   height: 20,
// ),
