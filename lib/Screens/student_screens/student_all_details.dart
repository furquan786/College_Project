import 'package:college_project/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StudentAllDetail extends StatefulWidget {
  var studenttoken;
  var studentid;
  StudentAllDetail({required this.studentid, required this.studenttoken});
  @override
  State<StudentAllDetail> createState() => _StudentAllDetailState();
}

class _StudentAllDetailState extends State<StudentAllDetail> {
  ScrollController scrollController = ScrollController();
  PageController _controller = PageController();
  @override
  void initState() {
    widget.studentid;
    widget.studenttoken;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
      ),
      backgroundColor: const Color.fromRGBO(244, 244, 247, 1),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 23.7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserratbold',
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
              margin: const EdgeInsets.only(left: 20, right: 20, top: 44),
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
              height: 35,
            ),
            studentHomeScreen(context, widget.studentid, widget.studenttoken),
            const SizedBox(
              height: 17,
            ),
            Container(
              constraints: const BoxConstraints(
                maxHeight: double.infinity,
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                left: 32,
                top: 30,
              ),
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
                ),
              ),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Notes",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserratbold',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Studentdetaillist(
                          "Big data analysis",
                          "12/2/2022",
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Studentdetaillist(
                          "Cyber Security",
                          "22/2/2022",
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Studentdetaillist(
                          "Internet of things",
                          "10/2/2022",
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Studentdetaillist(
                          "Data structure and algorithm",
                          "5/2/2022",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: const ScrollingDotsEffect(
                        dotColor: Colors.red,
                        radius: 8,
                        activeStrokeWidth: 30,
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: Colors.black,
                        activeDotScale: 2,
                        spacing: 10),
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Transaction",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserratbold',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 190,
                    width: 335,
                    padding: const EdgeInsets.only(right: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          studenttransactionlist(
                              "Transaction", "A", "+12000", "12/02/2022"),
                          const SizedBox(
                            height: 8,
                          ),
                          studenttransactionlist(
                              "Transaction", "B", "-12000", "15/05/2022"),
                          const SizedBox(
                            height: 8,
                          ),
                          studenttransactionlist(
                              "Transaction", "D", "-18000", "12/02/2022"),
                          const SizedBox(
                            height: 8,
                          ),
                          studenttransactionlist(
                              "Transaction", "F", "-22000", "12/02/2022"),
                          const SizedBox(
                            height: 8,
                          ),
                          studenttransactionlist(
                              "Transaction", "g", "-42000", "12/02/2022"),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
