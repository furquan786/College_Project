import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class StudentAttendance extends StatefulWidget {
  @override
  _StudentAttendanceState createState() => _StudentAttendanceState();
}

List<DateTime> presentDates = [
  DateTime(2022, 5, 1),
  DateTime(2022, 5, 3),
  DateTime(2022, 5, 9),
  DateTime(2022, 5, 11),
  DateTime(2022, 5, 15),
  DateTime(2022, 5, 4),
  DateTime(2022, 5, 6),
];
List<DateTime> absentDates = [
  DateTime(2022, 5, 2),
  DateTime(2022, 5, 7),
  DateTime(2022, 5, 8),
  DateTime(2022, 5, 12),
  DateTime(2022, 5, 13),
  DateTime(2022, 5, 14),
  DateTime(2022, 5, 5),
  DateTime(2022, 5, 10),
];

class _StudentAttendanceState extends State<StudentAttendance> {
  DateTime _currentDate2 = DateTime.now();
  static Widget _presentIcon(String day) => CircleAvatar(
        radius: 60,
        backgroundColor: Colors.green,
        child: Text(
          day,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      );
  static Widget _absentIcon(String day) => CircleAvatar(
        backgroundColor: Colors.red,
        child: Text(
          day,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      );

  final EventList<Event> _markedDateMap = EventList<Event>(
    events: {},
  );

  late CalendarCarousel _calendarCarouselNoHeader;

  var len = min(absentDates.length, presentDates.length);
  late double cHeight;

  @override
  Widget build(BuildContext context) {
    cHeight = MediaQuery.of(context).size.height;
    for (int i = 0; i < len; i++) {
      _markedDateMap.add(
        presentDates[i],
        Event(
          date: presentDates[i],
          title: 'Event 5',
          icon: _presentIcon(
            presentDates[i].day.toString(),
          ),
        ),
      );
    }

    for (int i = 0; i < len; i++) {
      _markedDateMap.add(
        absentDates[i],
        Event(
          date: absentDates[i],
          title: 'Event 5',
          icon: _absentIcon(
            absentDates[i].day.toString(),
          ),
        ),
      );
    }

    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      dayPadding: 4,
      height: cHeight * 0.54,
      weekendTextStyle: const TextStyle(
        color: Colors.red,
      ),
      todayButtonColor: Colors.blue.shade200,
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal:
          null, // null for not showing hidden events indicator
      markedDateIconBuilder: (event) {
        return event.icon;
      },
    );

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
      backgroundColor: Color.fromRGBO(213, 231, 255, 1),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Attendance".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 21,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserratbold',
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
              ),
              margin: EdgeInsets.only(top: 16),
              height: MediaQuery.of(context).size.height / 1.22,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Computer Network",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserratbold',
                        ),
                      ),
                      Text(
                        "Present",
                        style: TextStyle(
                          fontFamily: 'Montserratbold',
                          color: Colors.green,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Absent",
                        style: TextStyle(
                          fontFamily: 'Montserratbold',
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  _calendarCarouselNoHeader,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
