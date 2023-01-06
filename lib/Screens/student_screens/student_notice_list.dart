import 'dart:convert';
import 'package:flutter/material.dart';
import '../../constant.dart';
import 'package:http/http.dart' as http;

class StudentNoticesList extends StatefulWidget {
  var studenttoken;
  var studentid;
  StudentNoticesList({required this.studentid, required this.studenttoken});
  @override
  State<StudentNoticesList> createState() => _StudentNoticesListState();
}

class _StudentNoticesListState extends State<StudentNoticesList> {
  List data = [];
  bool isloading = false;
  @override
  void initState() {
    print("id is coming i think ${widget.studentid}");
    print("token data is comings i think ${widget.studenttoken}");
    this.fetchdata();
    super.initState();
  }

  fetchdata() async {
    var url =
        "https://aitsudaipur.herokuapp.com/api/get/notices/${widget.studentid}";
    var response = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${widget.studenttoken}",
      },
    );

    print("response is ${response.statusCode}");
    if (response.statusCode == 200) {
      var items = jsonDecode(response.body)['notices'];
      setState(() {
        data = items;
      });
      print(data);
    } else if (response.statusCode == 400) {
      setState(
        () {
          const Center(
            child: Text(
              "oops",
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 18,
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Notices",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            fontFamily: 'Poppinsbold',
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 10, top: 10),
          width: 343,
          constraints: const BoxConstraints(
            maxHeight: double.infinity,
          ),
          margin: const EdgeInsets.only(top: 11, left: 19, right: 23),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(242, 246, 255, 1),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                blurRadius: 8,
                offset: Offset(-2, 3),
              ),
            ],
          ),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  studentnoticelist(
                    context,
                    data[index],
                    "images/pic.jpg",
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width / 1.3,
                    // ignore: prefer_const_constructors
                    color: Color.fromRGBO(255, 255, 255, 0.562),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
