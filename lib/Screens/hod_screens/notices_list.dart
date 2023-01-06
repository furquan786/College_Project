import 'package:flutter/material.dart';
import '../../constant.dart';

class HodNoticesList extends StatefulWidget {
  @override
  State<HodNoticesList> createState() => _HodNoticesListState();
}

class _HodNoticesListState extends State<HodNoticesList> {
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
          "Notice",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 28, top: 16),
                  child: Text(
                    'Today',
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
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
                    )
                  ],
                ),
                child: Column(
                  children: [
                    hodnoticelist("notice title", "images/profile2.png",
                        "images/notice.jpeg"),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      height: 2,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    hodnoticelist("notice title", "images/profile2.png",
                        "images/notice.jpeg"),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      height: 2,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    hodnoticelist("notice title", "images/profile2.png",
                        "images/notice.jpeg"),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      height: 2,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    hodnoticelist("notice title", "images/profile2.png",
                        "images/notice.jpeg"),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      height: 2,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    hodnoticelist("notice title", "images/profile2.png",
                        "images/notice.jpeg"),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      height: 2,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    hodnoticelist("notice title", "images/profile2.png",
                        "images/notice.jpeg"),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      height: 2,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 28, top: 26),
                  child: Text(
                    'Yesterday',
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: 343,
                constraints: const BoxConstraints(
                  maxHeight: double.infinity,
                ),
                margin: const EdgeInsets.only(top: 31, left: 19, right: 23),
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
                    )
                  ],
                ),
                child: Column(
                  children: [
                    hodnoticelist("notice title", "images/profile2.png",
                        "images/notice.jpeg"),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      height: 2,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    hodnoticelist("notice title", "images/profile2.png",
                        "images/notice.jpeg"),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      height: 2,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    hodnoticelist("notice title", "images/profile2.png",
                        "images/notice.jpeg"),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      height: 2,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    hodnoticelist("notice title", "images/profile2.png",
                        "images/notice.jpeg"),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      height: 2,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    hodnoticelist("notice title", "images/profile2.png",
                        "images/notice.jpeg"),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      height: 2,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    hodnoticelist("notice title", "images/profile2.png",
                        "images/notice.jpeg"),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      height: 2,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
