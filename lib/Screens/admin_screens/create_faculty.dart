import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateFaculty extends StatefulWidget {
  @override
  State<CreateFaculty> createState() => _CreateFacultyState();
}

class _CreateFacultyState extends State<CreateFaculty> {
  var getid;
  var gettoken;
  String dropdownvalue = "B-TECH";
  String dropvalue = "NONE";
  var course = ["B-TECH", "MCA", "M-TECH", "BCA", "DIPLOMA"];
  var branch = ["CSE", "EE", "ME", "CE", "NONE"];
  @override
  void initState() {
    getidtoken();
    super.initState();
  }

  Future<void> getidtoken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      getid = pref.getString('id');
      gettoken = pref.getString('token');
    });
  }

  bool saving = false;
  TextEditingController fnamecontroller = TextEditingController();
  TextEditingController lnamecontroller = TextEditingController();
  TextEditingController mnocontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController rolecontroller = TextEditingController();
  TextEditingController coursecontroller = TextEditingController();
  TextEditingController bracnhconroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Future<void> createFaculty(String firstname, String lastname, String mno,
      String email, String course, String branch) async {
    print("branch is going ${branch}");
    var req = new Map();
    req['first_name'] = firstname;
    req['last_name'] = lastname;
    req['mno'] = mno;
    req['email'] = email;
    req['role'] = "faculty";
    req['course'] = course;
    req['department'] = branch;
    var response = await http.post(
      Uri.parse(
          "https://aitsudaipur.herokuapp.com/api/admin/create/faculty/$getid"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Bearer $gettoken",
      },
      body: jsonEncode(req),
    );
    var data = response.body;
    print("token is coming ${gettoken}");
    print("id is coming ${getid}");
    print("repsonse is ${response.statusCode}");
    print("data is going${data}");
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "${data}"
              .replaceRange(0, 10, '')
              .replaceAll('}', '')
              .replaceAll('"', "")
              .replaceAll('/', '')
              .replaceAll(':', '')
              .replaceAll(r'\', ''),
        ),
      ));
      setState(() {
        saving = false;
      });
      // print("student data is coming${studentdata}");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Padding(
          padding: EdgeInsets.only(
            top: 19,
          ),
          child: Text(
            'Create Faculty',
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
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/appbg2.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: saving,
          child: Container(
            color: Colors.black12,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  const CircleAvatar(
                    backgroundColor: Color.fromRGBO(1, 37, 81, 1),
                    radius: 50,
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage('images/profile.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Form(
                    key: formKey,
                    child: Container(
                      padding: EdgeInsets.only(top: 20),
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(50),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: fnamecontroller,
                            validator: (val) {
                              return val!.isEmpty
                                  ? "Enter First Name correctly"
                                  : null;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 34, top: 6),
                              border: InputBorder.none,
                              hintText: 'First-Name',
                              hintStyle: TextStyle(
                                  color: Colors.blueGrey.shade600,
                                  fontFamily: 'Poppinslight',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (val) {
                              return val!.isEmpty
                                  ? "Enter Last Name correctly"
                                  : null;
                            },
                            controller: lnamecontroller,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 13,
                                fontFamily: 'Ralewaylight',
                              ),
                              contentPadding: EdgeInsets.only(left: 34, top: 6),
                              border: InputBorder.none,
                              hintText: 'Last-Name',
                              hintStyle: TextStyle(
                                color: Colors.blueGrey.shade600,
                                fontFamily: 'Poppinslight',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              return val!.length < 10 || val.length > 10
                                  ? "Enter Mobile Number 10 Character"
                                  : null;
                            },
                            controller: mnocontroller,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 13,
                                fontFamily: 'Ralewaylight',
                              ),
                              contentPadding: EdgeInsets.only(left: 34, top: 6),
                              border: InputBorder.none,
                              hintText: 'Enter-Mobile Number',
                              hintStyle: TextStyle(
                                color: Colors.blueGrey.shade600,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppinslight',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: emailcontroller,
                            validator: (val) {
                              return val!.isEmpty
                                  ? "Enter Email correctly"
                                  : null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 34, top: 6),
                              border: InputBorder.none,
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  color: Colors.blueGrey.shade600,
                                  fontFamily: 'Poppinslight',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.only(top: 6),
                            height: 70,
                            width: 300,
                            child: DropdownButton(
                              value: dropdownvalue,
                              underline: Container(
                                margin: EdgeInsets.only(right: 2),
                                height: 1,
                                color: Colors.black12,
                              ),
                              menuMaxHeight: 100,
                              style: const TextStyle(
                                color: Colors.black,
                                letterSpacing: 1.3,
                                fontFamily: 'Montserratlight',
                                fontWeight: FontWeight.normal,
                              ),
                              isExpanded: true,
                              icon: const Padding(
                                padding: EdgeInsets.only(top: 30, right: 6),
                                child: Icon(Icons.keyboard_arrow_down),
                              ),
                              items: course.map(
                                (String branch) {
                                  return DropdownMenuItem<String>(
                                    value: branch,
                                    child: Text(branch),
                                  );
                                },
                              ).toList(),
                              onChanged: (String? newvalue) {
                                setState(() {
                                  dropdownvalue = newvalue!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          dropdownvalue.contains("MCA") ||
                                  dropdownvalue.contains("BCA")
                              ? const SizedBox(
                                  height: 20,
                                )
                              : Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.only(top: 6),
                                  height: 70,
                                  width: 300,
                                  child: DropdownButton(
                                    value: dropvalue,
                                    underline: Container(
                                      margin: EdgeInsets.only(right: 3),
                                      height: 1,
                                      color: Colors.black12,
                                    ),
                                    menuMaxHeight: 100,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 1.3,
                                      fontFamily: 'Montserratlight',
                                      fontWeight: FontWeight.normal,
                                    ),
                                    isExpanded: true,
                                    icon: const Padding(
                                      padding:
                                          EdgeInsets.only(top: 30, right: 6),
                                      child: Icon(Icons.keyboard_arrow_down),
                                    ),
                                    items: branch.map(
                                      (String branch) {
                                        return DropdownMenuItem<String>(
                                          value: branch,
                                          child: Text(branch),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (String? newvalue) {
                                      setState(() {
                                        dropvalue = newvalue!;
                                      });
                                    },
                                  ),
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  saving = true;
                                });
                                try {
                                  createFaculty(
                                      fnamecontroller.text,
                                      lnamecontroller.text,
                                      mnocontroller.text,
                                      emailcontroller.text,
                                      dropdownvalue,
                                      dropvalue);
                                  fnamecontroller.clear();
                                  lnamecontroller.clear();
                                  mnocontroller.clear();
                                  emailcontroller.clear();
                                  rolecontroller.clear();
                                  coursecontroller.clear();
                                  bracnhconroller.clear();
                                } catch (e) {
                                  print("execption in api calls ${e}");
                                  setState(() {
                                    saving = false;
                                  });
                                }
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
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
                                  'Save',
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
