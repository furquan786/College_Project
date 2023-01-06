import 'package:college_project/Screens/hod_screens/complain_list.dart';
import 'package:college_project/Screens/hod_screens/notices_list.dart';
import 'package:college_project/Screens/student_screens/schedule_screen.dart';
import 'package:college_project/Screens/student_screens/student_fee.dart';
import 'package:college_project/Screens/student_screens/student_notice_details.dart';
import 'package:college_project/Screens/student_screens/student_notice_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

import 'Screens/student_screens/complain_screen.dart';

const textfielddecoration = InputDecoration(
  border: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 12.0,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
  ),
  filled: true,
  fillColor: Colors.black26,
  hintText: 'Enter Your E-Mail',
  hintStyle: TextStyle(
    color: Colors.black54,
  ),
);

class Carditem {
  final String imagepath;
  final VoidCallback onPress;
  final String title;
  final TextStyle style;

  const Carditem(
      {required this.imagepath,
      required this.title,
      required this.style,
      required this.onPress});
}

Widget profiledata(IconData iconData, String text, String name) {
  return Padding(
    padding: const EdgeInsets.all(9.0),
    child: Row(
      children: [
        Icon(
          iconData,
          size: 26,
          color: Colors.blueGrey.shade600,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Montserratlight',
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            name,
            textAlign: TextAlign.left,
            overflow: TextOverflow.clip,
            softWrap: false,
            style: const TextStyle(
              // overflow: TextOverflow.ellipsis,
              fontFamily: 'Poppinsbold',
              decoration: TextDecoration.underline,
              decorationColor: Colors.black,
              decorationStyle: TextDecorationStyle.solid,
              decorationThickness: 1.4,
              wordSpacing: 1.2,
              letterSpacing: 1.3,
              color: Colors.black38,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget Adminprofiledata(IconData iconData, String name) {
  return Padding(
    padding: const EdgeInsets.only(left: 25, top: 15),
    child: Row(
      children: [
        Icon(
          iconData,
          size: 26,
          color: Colors.blueGrey.shade600,
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: Text(
            name,
            textAlign: TextAlign.left,
            overflow: TextOverflow.clip,
            softWrap: false,
            style: const TextStyle(
              // overflow: TextOverflow.ellipsis,
              fontFamily: 'Montserratbold',
              wordSpacing: 1.2,
              letterSpacing: 1.3,
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

TextStyle boldtexstyle = const TextStyle(
  fontSize: 25,
  color: Colors.white,
  fontFamily: 'Montserratbold',
  fontWeight: FontWeight.bold,
);

TextStyle loginlightfont = const TextStyle(
  color: Colors.grey,
  letterSpacing: 1.5,
  fontSize: 14,
  fontFamily: 'Montserratmediium',
  fontWeight: FontWeight.normal,
);

Widget studenthome(IconData _icon, String name, VoidCallback onpress) {
  return GestureDetector(
    onTap: onpress,
    child: Container(
      padding: const EdgeInsets.all(3.5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 8,
            offset: Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            _icon,
            size: 28,
            color: const Color.fromRGBO(1, 37, 81, 1),
          ),
          Text(
            name,
            style: const TextStyle(
                color: Color.fromRGBO(1, 37, 81, 1),
                fontSize: 13,
                fontFamily: 'Montserratbold',
                fontWeight: FontWeight.bold,
                letterSpacing: 1.4),
          ),
        ],
      ),
    ),
  );
}

Widget hodHomeScreen(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const SizedBox(
        width: 10,
      ),
      Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ComplainList(),
                ),
              );
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(42, 54, 78, 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
              child: Center(
                child: Image.asset(
                  'images/home2.png',
                  height: 38,
                  width: 38,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Complain",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
      Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(42, 54, 78, 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(26),
              ),
            ),
            child: Center(
              child: Image.asset(
                'images/home4.png',
                height: 38,
                width: 38,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Schedule",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
      Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HodNoticesList(),
                ),
              );
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(42, 54, 78, 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
              child: Center(
                child: Image.asset(
                  'images/home3.png',
                  height: 38,
                  width: 38,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Notices",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
      Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(42, 54, 78, 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(26),
              ),
            ),
            child: Center(
              child: Image.asset(
                'images/home1.png',
                height: 38,
                width: 38,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Add",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
      const SizedBox(
        width: 10,
      ),
    ],
  );
}

Widget hodnoticelist(String titile, String imagepath, String imagepath2) {
  return Row(
    children: [
      Container(
        height: 35,
        width: 35,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(42, 54, 78, 1),
        ),
        child: Center(
          child: Image.asset(
            imagepath,
            fit: BoxFit.contain,
            height: 20,
            width: 20,
          ),
        ),
      ),
      const SizedBox(
        width: 17,
      ),
      Text(
        titile,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      const Spacer(),
      Container(
        height: 35,
        width: 47,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(imagepath2),
          fit: BoxFit.contain,
        )),
      )
    ],
  );
}

Widget Studentdetaillist(String text, String date) {
  return Container(
    padding: const EdgeInsets.only(left: 21, bottom: 20),
    width: 313,
    height: 164,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(22),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black54,
          blurRadius: 8,
          offset: Offset(5, 5),
        ),
      ],
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(42, 54, 78, 1),
          Color.fromRGBO(8, 11, 16, 1),
        ],
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppinsbold',
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            date,
            style: const TextStyle(
              fontSize: 9,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppinsbold',
            ),
          ),
        )
      ],
    ),
  );
}

Widget studentHomeScreen(BuildContext context, var sid, var stoken) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const SizedBox(
        width: 10,
      ),
      Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: StudentComplain(),
                  type: PageTransitionType.fade,
                ),
              );
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(42, 54, 78, 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
              child: Center(
                child: Image.asset(
                  'images/home2.png',
                  height: 38,
                  width: 38,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Complain",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Poppinsbold',
            ),
          ),
        ],
      ),
      Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: StudentSchedule(),
                  type: PageTransitionType.rightToLeft,
                ),
              );
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(42, 54, 78, 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
              child: Center(
                child: Image.asset(
                  'images/home4.png',
                  height: 38,
                  width: 38,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Schedule",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Poppinsbold',
            ),
          ),
        ],
      ),
      Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: StudentNoticesList(
                    studentid: sid,
                    studenttoken: stoken,
                  ),
                  type: PageTransitionType.rotate,
                  alignment: Alignment.topRight,
                ),
              );
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(42, 54, 78, 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
              child: Center(
                child: Image.asset(
                  'images/home3.png',
                  height: 38,
                  width: 38,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Notices",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Poppinsbold',
            ),
          ),
        ],
      ),
      Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                    child: StudentFees(), type: PageTransitionType.bottomToTop),
              );
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(42, 54, 78, 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(26),
                ),
              ),
              child: Center(
                child: Image.asset(
                  'images/rupee.webp',
                  height: 26,
                  width: 26,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Pay",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Poppinsbold',
            ),
          ),
        ],
      ),
      const SizedBox(
        width: 10,
      ),
    ],
  );
}

Widget studenttransactionlist(
    String titile, String logo, String amount, String date) {
  return Row(
    children: [
      Container(
        height: 35,
        width: 35,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(42, 54, 78, 1),
        ),
        child: Center(
          child: Text(
            logo,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      const SizedBox(
        width: 17,
      ),
      Column(
        children: [
          Text(
            titile,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Poppinsbold',
            ),
          ),
          Text(
            date,
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              fontFamily: 'Poppinsbold',
            ),
          ),
        ],
      ),
      const Spacer(),
      Align(
        alignment: Alignment.bottomRight,
        child: Text(
          amount,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Montserratbold',
          ),
        ),
      ),
    ],
  );
}

Widget studentnoticelist(
  context,
  index,
  String imagepath,
) {
  var title = index['title'];
  var date = index['createdAt'];
  var id = index['_id'];
  var description = index['description'];

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StudentNoticeDetail(
            id: id,
            title: title,
            date: date,
            description: description,
          ),
        ),
      );
    },
    child: Row(
      children: [
        Container(
          height: 35,
          width: 35,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(42, 54, 78, 1),
          ),
          child: Center(
            child: Image.asset(
              imagepath,
              fit: BoxFit.contain,
              height: 20,
              width: 20,
            ),
          ),
        ),
        const SizedBox(
          width: 17,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toString().isEmpty ? "NOthing" : title.toString(),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Poppinsbold',
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              date.toString().isEmpty
                  ? "Null"
                  : "$date".replaceRange(10, 24, ''),
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.normal,
                fontFamily: 'Montserratmediium',
                color: Color.fromARGB(79, 0, 0, 0),
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          height: 35,
          width: 47,
          child: Image.network(
            'https://aitsudaipur.herokuapp.com/api/get/photo/notice/$id',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.network(
                'https://drukasia.com/images/stripes/monk3.jpg',
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget studentprofile(IconData icon, String title) {
  return Row(
    children: [
      Icon(
        icon,
        size: 15,
        color: const Color.fromRGBO(0, 0, 0, 0.404),
      ),
      const SizedBox(
        width: 27.8,
      ),
      Text(
        title,
        style: const TextStyle(
          fontFamily: 'Poppinsmedium',
          fontSize: 16,
          color: Color.fromRGBO(99, 99, 99, 1),
          fontWeight: FontWeight.bold,
        ),
      ),
      const Spacer(),
      const Icon(
        Icons.arrow_forward_ios,
        size: 15,
        color: Color.fromRGBO(0, 0, 0, 0.404),
      )
    ],
  );
}
