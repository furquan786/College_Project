import 'dart:convert';
import 'package:college_project/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminTeacherProfileScreen extends StatefulWidget {
  final String teacherid;
  var adminid;
  var putadmintoken;
  AdminTeacherProfileScreen(
      {required this.teacherid,
      required this.adminid,
      required this.putadmintoken});
  @override
  State<AdminTeacherProfileScreen> createState() =>
      _AdminTeacherProfileScreenState();
}

class _AdminTeacherProfileScreenState extends State<AdminTeacherProfileScreen> {
  String? firstname;
  late String lastname;
  late String email;
  late String course;
  late String role;
  late String department;
  late int mno;

  @override
  void initState() {
    getteacher(widget.teacherid, widget.adminid, widget.putadmintoken);
    print("admin id is coming ${widget.adminid}");
    print("teacher id is coming ${widget.teacherid}");
    super.initState();
  }

  Future<void> deletefaculty(var teachertoken, var id) async {
    final response = await http.delete(
      Uri.parse(
          'https://aitsudaipur.herokuapp.com/api/admin/delete/faculty/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer $teachertoken",
      },
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context, true);
    } else {
      print("response is ${response.statusCode}");
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

  Future<void> getteacher(String adminid, var teacherid, var admintoken) async {
    final response = await http.get(
      Uri.parse(
          'https://aitsudaipur.herokuapp.com/api/admin/get/teacher/$adminid/$teacherid'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $admintoken",
      },
    );
    print("response is ${response.statusCode}");
    setState(() {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        print("data is coming ${data}");
        if (data != null) {
          firstname = data['faculty']['first_name'];
          lastname = data['faculty']['last_name'];
          email = data['faculty']['email'];
          course = data['faculty']['course'];
          role = data['faculty']['role'];
          department = data['faculty']['department'];
          mno = data['faculty']['mno'];
        } else {
          print("error");
        }
      } else {
        throw Exception('an error ocured');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.9803921568627451),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              height: MediaQuery.of(context).size.height,
              child: firstname != null
                  ? Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Spacer(),
                        profiledata(Icons.account_circle_outlined, 'Name:-',
                            firstname! + ' ' + lastname),
                        const SizedBox(
                          height: 10,
                        ),
                        profiledata(Icons.mail_outline, 'Email:-', email),
                        const SizedBox(
                          height: 10,
                        ),
                        profiledata(Icons.class_outlined, 'Course:-', course),
                        const SizedBox(
                          height: 10,
                        ),
                        profiledata(Icons.work_outline_sharp, 'Role:-', role),
                        department.contains("NONE")
                            ? const SizedBox(
                                height: 0.2,
                              )
                            : const SizedBox(
                                height: 10,
                              ),
                        department.contains("NONE")
                            ? const SizedBox(
                                height: 0.2,
                              )
                            : profiledata(
                                Icons.note_outlined,
                                'Branch:-',
                                department,
                              ),
                        department.contains("NONE")
                            ? const SizedBox(
                                height: 0.2,
                              )
                            : const SizedBox(
                                height: 10,
                              ),
                        profiledata(
                            Icons.phone, 'contact no.:-', mno.toString()),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                try {
                                  deletefaculty(
                                      widget.putadmintoken, widget.teacherid);
                                } catch (e) {
                                  print(e);
                                }
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
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      fontFamily: 'Ralewaybold',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
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
                                  'Appoint HOD',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    fontFamily: 'Ralewaybold',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          width: 240,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(1, 37, 81, 1),
                                  blurRadius: 4,
                                  offset: Offset(5, 5)),
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
                              'Send Message',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                fontFamily: 'Ralewaybold',
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
          Positioned(
            bottom: 540,
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              automaticallyImplyLeading: false,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.elliptical(200, 30),
                  bottomLeft: Radius.elliptical(200, 30),
                ),
              ),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.elliptical(200, 30),
                    bottomLeft: Radius.elliptical(200, 30),
                  ),
                  image: DecorationImage(
                    image: AssetImage('images/appbg2.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 400,
              left: 120,
              right: 120,
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // color: Colors.red,
              ),
              child: const Center(
                child: CircleAvatar(
                  backgroundColor: Color.fromRGBO(1, 37, 81, 1),
                  radius: 60,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: AssetImage('images/profile.png'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
