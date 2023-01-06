import 'dart:convert';
import 'package:college_project/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FacultyHomeScreen extends StatefulWidget {
  @override
  State<FacultyHomeScreen> createState() => _FacultyHomeScreenState();
}

class _FacultyHomeScreenState extends State<FacultyHomeScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    getdepartment();
    super.initState();
  }

  var department;
  var id;

  Future<void> getdepartment() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      department = pref.getString('department');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 244, 247, 1),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 41, left: 35, right: 23.7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Icon(
                    Icons.notifications,
                    size: 20,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 24),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
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
                          fontFamily: 'Ralewayextralight',
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            hodHomeScreen(context),
            const SizedBox(
              height: 7,
            ),
            Container(
              height: 520,
              width: 375,
              padding: EdgeInsets.only(bottom: 40),
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 8,
                      offset: Offset(-2, 5),
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  )),
              child: FutureBuilder<List<dynamic>>(
                future: fetchdetail(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print("snapshot error in hod home ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    return GridView.builder(
                      controller: scrollController,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 80),
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
                          onTap: () {},
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.5)),
                            elevation: 12.0,
                            child: Column(
                              children: [
                                Image.asset('images/profile.png'),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 14,
                                    ),
                                    child: Text(
                                      "${teacherdetails!['first_name'] + " " + teacherdetails['last_name']}"
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Ralewaybold',
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
                                          fontSize: 15,
                                          fontFamily: 'Ralewaylight',
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
                                          fontSize: 15,
                                          fontFamily: 'Ralewaylight',
                                          color: Colors.grey.shade800),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  var puttoken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyNTU3MzU5YjQ0NDY3OTY1NWQ1ZmZhNiIsInJvbGUiOiJzdXBlcmFkbWluIiwiaWF0IjoxNjUxNDY2MzIyfQ.8nGZmNuPTLesM1RjhmUBLQUIKMmj9mtl8_Dfxs-B06w';

  Future<List<dynamic>> fetchdetail() async {
    final response = await http.get(
      Uri.parse(
          'https://aitsudaipur.herokuapp.com/api/admin/all/students/B-TECH/$department/62557359b444679655d5ffa6'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Bearer $puttoken",
      },
    );
    var data = response.body;
    print("data is coming in hod home  ${data}");
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse['faculties'];
    } else {
      throw Exception("an error occur");
    }
  }
}
