import 'dart:convert';
import 'package:college_project/sign_up_screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

class ScholarScreen extends StatefulWidget {
  @override
  State<ScholarScreen> createState() => _ScholarScreenState();
}

class _ScholarScreenState extends State<ScholarScreen> {
  bool saving = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController scholarcontroller = TextEditingController();
  var studentdata;

  Future<void> scholarnumberverification(String scholarnumber) async {
    var req = new Map();
    req['scholar_number'] = int.parse(scholarnumber);
    var response = await http.post(
        Uri.parse(
            "https://aitsudaipur.herokuapp.com/api/signup/student/scholar_number/verify"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(req));
    var data = response.body;
    studentdata = jsonDecode(data);
    print("response is${response.statusCode}");
    if (response.statusCode == 200) {
      setState(() {
        saving = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(
            data: studentdata,
          ),
        ),
      );
      // print("student data is coming${studentdata}");
      return studentdata;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 48, 76, 1),
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
            margin: EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Step 1 of 3'.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'Montserratmediium',
                            color: Color.fromRGBO(1, 37, 81, 1),
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 36, top: 14),
                    child: Text(
                      'What is your scholar no?',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontFamily: 'Montserratbold',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 66, top: 14),
                    child: Text(
                      'We want to make sure you’re enter correct scholar'
                      'number',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black54,
                        fontFamily: 'Poppinslight',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(1, 37, 81, 1),
                            blurRadius: 8,
                            offset: Offset(5, 5),
                          ),
                        ]),
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        validator: (val) {
                          return val!.length < 6 || val.length > 6
                              ? "Enter Scholar Number 6 Character"
                              : null;
                        },
                        controller: scholarcontroller,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontFamily: 'Poppinslight',
                          ),
                          contentPadding:
                              EdgeInsets.only(left: 14, top: 10, bottom: 3),
                          border: InputBorder.none,
                          hintText: 'Enter Your Scholar no.',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade900,
                            fontFamily: 'Montserratmediium',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          saving = true;
                        });
                        try {
                          scholarnumberverification(scholarcontroller.text);
                          scholarcontroller.clear();
                        } catch (e) {
                          print("execption in api calls ${e}");
                          setState(() {
                            saving = false;
                          });
                        }
                      }
                    },
                    child: Container(
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
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                    child: Text(
                      'By continuing, you agree to accept our',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontFamily: 'Montserratmediium',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Center(
                    child: Text(
                      'Privacy Policy & Terms of Service',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontFamily: 'Montserratmediium',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
