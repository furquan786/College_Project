import 'dart:convert';
import 'package:college_project/Screens/admin_screens/student_profile.dart';
import 'package:college_project/Screens/admin_screens/teacher_profile_screen.dart';
import 'package:college_project/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen>
    with SingleTickerProviderStateMixin {
  var putid;
  var puttoken;
  @override
  void initState() {
    isloading = true;
    Future.delayed(
      Duration(seconds: 10),
    ).whenComplete(() {
      setState(() {
        isloading = false;
      });
    });
    get_id_token();
    super.initState();
  }

  bool isloading = false;

  Future<List<dynamic>> fetchStudent() async {
    final studentresponse = await http.get(
      Uri.parse(
          'https://aitsudaipur.herokuapp.com/api/admin/get/student/all/$putid'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $puttoken",
      },
    );
    var data = studentresponse.body;
    if (studentresponse.statusCode == 200) {
      Map<String, dynamic> studentjsonResponse =
          json.decode(studentresponse.body);
      return studentjsonResponse['students'];
    } else {
      throw Exception("an error occur");
    }
  }

  Future<List<dynamic>> fetchdetail() async {
    final response = await http.get(
      Uri.parse(
          'https://aitsudaipur.herokuapp.com/api/admin/all/teachers/$putid'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $puttoken",
      },
    );
    var data = response.body;
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse['faculties'];
    } else {
      throw Exception("an error occur");
    }
  }

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 11, bottom: 6),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset('images/profile.png'),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Home',
          style: TextStyle(
            fontSize: 24,
            color: Color(0xFF000000),
            fontFamily: 'Montserratbold',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 14),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: const [
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.search,
                          size: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabled: true,
                          hintText: "search....",
                          contentPadding: EdgeInsets.only(left: 15),
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontFamily: 'Poppinslight',
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 17, left: 7, right: 6),
                child: Container(
                  height: 70,
                  child: ListView.separated(
                    separatorBuilder: (context, _) => SizedBox(
                      width: 12,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) => cards(item: items[index]),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 18.2, left: 20.4),
                  child: Text(
                    'Professors',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Ralewaybold',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              FutureBuilder<List<dynamic>>(
                  future: fetchdetail(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print("snapshot error in admin home ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      return GridView.builder(
                          controller: scrollController,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                          itemCount: snapshot.data?.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 240,
                            crossAxisCount: 2,
                            crossAxisSpacing: 3,
                          ),
                          itemBuilder: (context, index) {
                            Map<String, dynamic>? teacherdetails =
                                snapshot.data![index];
                            String id = snapshot.data![index]['_id'];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.leftToRight,
                                      child: AdminTeacherProfileScreen(
                                        teacherid: id,
                                        adminid: putid,
                                        putadmintoken: puttoken,
                                      ),
                                      inheritTheme: true,
                                      ctx: context),
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.5)),
                                elevation: 12.0,
                                child: Column(
                                  children: [
                                    teacherdetails!['course']
                                            .toString()
                                            .contains("B-TECH")
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: Image.asset(
                                              'images/profile2.png',
                                            ),
                                          )
                                        : Image.asset('images/profile.png'),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 14,
                                          top: 8,
                                        ),
                                        child: Text(
                                          "${teacherdetails['first_name'] + " " + teacherdetails['last_name']}"
                                              .toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontFamily: 'Montserratbold',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, bottom: 6),
                                        child: Text(
                                          teacherdetails['course'],
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Poppinslight',
                                              fontWeight: FontWeight.w200,
                                              color: Colors.grey.shade800),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, bottom: 16),
                                        child: Text(
                                          "${teacherdetails['department']}"
                                                  .contains("NONE")
                                              ? ""
                                              : teacherdetails['department'],
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Poppinslight',
                                              fontWeight: FontWeight.w200,
                                              color: Colors.grey.shade800),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                    return Container(
                      height: 45,
                    );
                  }),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 18.2, left: 20.4),
                  child: Text(
                    "Student",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserratbold',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 11,
              ),
              FutureBuilder<List<dynamic>>(
                future: fetchStudent(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print("snapshot error ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    return GridView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                        itemCount: snapshot.data?.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 240,
                          crossAxisCount: 2,
                          crossAxisSpacing: 3,
                        ),
                        itemBuilder: (context, index) {
                          Map<String, dynamic>? studentdetails =
                              snapshot.data![index];
                          String id = snapshot.data![index]['_id'];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    child: AdminStudentProfileScreen(
                                      id: id,
                                      putStudentid: putid,
                                      putStudenttoken: puttoken,
                                    ),
                                    inheritTheme: true,
                                    ctx: context),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.5),
                              ),
                              elevation: 12.0,
                              child: Column(
                                children: [
                                  studentdetails!['course']
                                          .toString()
                                          .contains("B-TECH")
                                      ? Image.asset('images/profile2.png')
                                      : Image.asset('images/profile.png'),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 14,
                                      ),
                                      child: Text(
                                        "${studentdetails['first_name'] + " " + studentdetails['last_name']}"
                                            .toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Montserratbold',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, bottom: 6),
                                      child: Text(
                                        studentdetails['course'],
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Poppinslight',
                                            fontWeight: FontWeight.w200,
                                            color: Colors.grey.shade800),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, bottom: 16),
                                      child: Text(
                                        "${studentdetails['branch_name']}"
                                                .contains("NONE")
                                            ? ""
                                            : studentdetails['branch_name'],
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Poppinslight',
                                            fontWeight: FontWeight.w200,
                                            color: Colors.grey.shade800),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  return isloading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const Center(
                          child: Text(
                            'An error occured, please relogin \n    or check your connection',
                            style: TextStyle(
                              height: 1.2,
                              fontSize: 16,
                              color: Colors.red,
                              fontFamily: 'Poppinsmedium',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                  ;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> get_id_token() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      putid = pref.getString('id')!;
      puttoken = pref.getString('token')!;
    });
  }

  Widget cards({required Carditem item}) => Container(
        width: 61,
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: item.onPress,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(
                        item.imagepath,
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              item.title,
              style: item.style,
            )
          ],
        ),
      );

  List<Carditem> items = [
    Carditem(
      imagepath: 'images/menu2.png',
      title: 'All',
      style: const TextStyle(
        fontSize: 15,
        color: Colors.black,
        fontFamily: 'Poppinsbold',
        fontWeight: FontWeight.bold,
      ),
      onPress: () {},
    ),
    Carditem(
      imagepath: 'images/bca.jpg',
      title: 'BCA',
      style: const TextStyle(
        fontSize: 15,
        color: Colors.grey,
        fontFamily: 'Poppinslight',
        fontWeight: FontWeight.w200,
      ),
      onPress: () {},
    ),
    Carditem(
      imagepath: 'images/B.Tech.png',
      title: 'B.tech',
      style: const TextStyle(
          fontSize: 15,
          color: Colors.grey,
          fontFamily: 'Poppinslight',
          fontWeight: FontWeight.w200),
      onPress: () {},
    ),
    Carditem(
      imagepath: 'images/just.png',
      title: 'Diploma',
      style: const TextStyle(
        fontSize: 15,
        overflow: TextOverflow.ellipsis,
        color: Colors.grey,
        fontFamily: 'Poppinslight',
        fontWeight: FontWeight.w200,
      ),
      onPress: () {},
    ),
    Carditem(
      imagepath: 'images/just.png',
      title: 'M.tech',
      style: const TextStyle(
          fontSize: 15,
          color: Colors.grey,
          fontFamily: 'Poppinslight',
          fontWeight: FontWeight.w200),
      onPress: () {},
    ),
    Carditem(
      imagepath: 'images/just.png',
      title: 'MCA',
      style: const TextStyle(
        fontSize: 15,
        color: Colors.grey,
        fontFamily: 'Poppinslight',
        fontWeight: FontWeight.w200,
      ),
      onPress: () {},
    ),
  ];
}
