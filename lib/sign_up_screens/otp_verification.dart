import 'dart:convert';
import 'package:college_project/Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:http/http.dart' as http;

class OTPVerification extends StatefulWidget {
  var otptoken;
  OTPVerification({required this.otptoken});
  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  TextEditingController codeController = TextEditingController();
  @override
  void initState() {
    gettoken(widget.otptoken);
    print("token is coming from ${widget.otptoken}");
    super.initState();
  }

  late String tokens;
  void gettoken(Map<String, dynamic> tokenget) {
    setState(() {
      try {
        if (tokenget == null) {
          tokens = 'nulll';
        } else {
          tokens = tokenget['otpVerificationToken'];
          print("tokens is coming ${tokens}");
        }
      } catch (e) {
        print("exceptoipn is${e}");
      }
    });
  }

  Future<void> verifyotp(String otp) async {
    var req = new Map();
    req['otp'] = int.parse(otp);
    print("otp giving ${otp}");
    var response = await http.post(
        Uri.parse(
            "https://aitsudaipur.herokuapp.com/api/signup/student/verifyotp"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $tokens",
        },
        body: jsonEncode(req));
    var data = response.body;
    print("data is${data}");
    print("response is ${response.statusCode}");
    if (response.statusCode == 200) {
      setState(() {
        saving = false;
      });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false);
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

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Step 3 of 3'.toUpperCase(),
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
                    padding: EdgeInsets.only(top: 40, left: 15),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Enter OTP',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontFamily: 'Montserratbold',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Center(
                      child: Container(
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 90,
                            offset: Offset(0, 5),
                          )
                        ]),
                        width: 0.9 * screenSize.width,
                        height: 52,
                        child: PinFieldAutoFill(
                          keyboardType: TextInputType.number,
                          controller: codeController,
                          codeLength: 4,
                          currentCode: codeController.text,
                          autoFocus: true,
                          decoration: const BoxLooseDecoration(
                            gapSpace: 30,
                            strokeColorBuilder: FixedColorBuilder(
                              Color.fromRGBO(1, 37, 81, 1),
                            ),
                            strokeWidth: 0.2,
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 24,
                    ),
                    child: Center(
                      child: Text(
                        'Four digits of code send to the your mobile\n'
                        '               enter that code to continue',
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 15,
                          color: Colors.black38,
                          fontFamily: 'Montserratmediium',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 67),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          try {
                            verifyotp(codeController.text);
                            setState(() {
                              saving = true;
                            });
                          } catch (e) {
                            print("exception is${e} ");
                          }
                        },
                        child: Container(
                          width: 320,
                          height: 52,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(1, 37, 81, 1),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(1, 37, 81, 1),
                                    blurRadius: 8,
                                    offset: Offset(2, 2),
                                    blurStyle: BlurStyle.inner)
                              ]),
                          child: const Center(
                            child: Text(
                              'Submit',
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
