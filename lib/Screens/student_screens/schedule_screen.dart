import 'package:flutter/material.dart';
import 'package:college_project/custom_calender/month_date_day.dart'
    as date_util;

class StudentSchedule extends StatefulWidget {
  StudentSchedule({Key? key}) : super(key: key);

  @override
  State<StudentSchedule> createState() => _StudentScheduleState();
}

class _StudentScheduleState extends State<StudentSchedule> {
  DateTime currentDateTime = DateTime.now();
  List<DateTime> currentMonthList = List.empty();
  late ScrollController scrollController;
  @override
  void initState() {
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 70.0 * currentDateTime.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(213, 231, 255, 1),
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
      body: Column(
        children: [
          titleView(),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 1.25,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 12),
                  height: 51,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: currentMonthList.length,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return capsuleView(index);
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.6,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 27,
                                ),
                                const Text(
                                  '7:00',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800),
                                ),
                                const Text(
                                  'AM',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(172, 172, 172, 1),
                                      fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.8,
                                ),
                                const Text(
                                  '1hr 45min',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(172, 172, 172, 1),
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 22, top: 30),
                              width: 334,
                              height: 164,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromRGBO(235, 235, 239, 1),
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Theory of Compution',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                      fontFamily: 'Montserratbold',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 31,
                                  ),
                                  Text(
                                    'Dr. Jitendra Singh',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromRGBO(114, 114, 114, 1),
                                        fontFamily: 'Poppinslight',
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    '89542564782',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color.fromRGBO(184, 184, 184, 1),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Department CSE',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(114, 114, 114, 1),
                                      fontFamily: 'Poppinslight',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Room no. 204, first floor',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Poppinslight',
                                      fontWeight: FontWeight.w300,
                                      color: Color.fromRGBO(184, 184, 184, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget capsuleView(int index) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentDateTime = currentMonthList[index];
          });
        },
        child: Container(
          margin: EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            color: (currentMonthList[index].day != currentDateTime.day)
                ? Colors.white
                : Color.fromRGBO(60, 49, 196, 1),
          ),
          height: 11,
          width: 36,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                date_util
                    .DateUtils.weekdays[currentMonthList[index].weekday - 1],
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(184, 184, 193, 1),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                currentMonthList[index].day.toString(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: (currentMonthList[index].day != currentDateTime.day)
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleView() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        top: 10,
      ),
      child: Row(
        children: [
          // ignore: prefer_const_constructors
          Icon(
            Icons.calendar_today,
            size: 35,
            color: Color.fromRGBO(0, 0, 0, 0.667),
          ),
          const SizedBox(
            width: 22,
          ),
          Text(
            date_util.DateUtils.months[currentDateTime.month - 1],
            style: const TextStyle(
                color: Color.fromRGBO(37, 46, 101, 1),
                fontWeight: FontWeight.bold,
                fontSize: 35),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 13, left: 2),
            child: Text(
              currentDateTime.year.toString(),
              style: const TextStyle(
                  color: Color.fromRGBO(134, 149, 197, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
