import 'package:college_project/buttons/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StudentFees extends StatefulWidget {
  @override
  State<StudentFees> createState() => _StudentFeesState();
}

class _StudentFeesState extends State<StudentFees> {
  PageController _controller = PageController();

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
      body: Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 35, top: 20),
              child: Text(
                'Hello',
                style: TextStyle(
                  fontFamily: 'Poppinsbold',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color.fromRGBO(153, 153, 153, 1),
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 35, top: 0),
              child: Text(
                'Example',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppinsbold',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 38,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 110,
            child: ListView.builder(
                padding: EdgeInsets.only(left: 20, right: 20),
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(4),
                    width: 190,
                    height: 110,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(23),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('images/adds.png'),
                      ),
                    ),
                  );
                }),
          ),
          const SizedBox(
            height: 5,
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: 3,
            effect: const ScrollingDotsEffect(
              dotColor: Color.fromARGB(16, 0, 0, 0),
              radius: 8,
              activeStrokeWidth: 30,
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Colors.green,
              activeDotScale: 2,
              spacing: 10,
            ),
          ),
          const SizedBox(height: 31),
          Row(
            children: [
              const SizedBox(
                width: 18,
              ),
              Roundedbutton(
                tsize: 15,
                isize: 20,
                title: 'Qr Scan',
                color: Color.fromRGBO(42, 54, 78, 1),
                onPress: () {},
                icon: Icons.qr_code,
              ),
              const SizedBox(
                width: 18,
              ),
              Roundedbutton(
                tsize: 15,
                isize: 20,
                title: 'To Bank',
                color: Color.fromRGBO(42, 54, 78, 1),
                onPress: () {},
                icon: FontAwesomeIcons.bank,
              ),
            ],
          ),
          const SizedBox(
            height: 46,
          ),
          Container(
            padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
            height: 120,
            width: 339,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
              color: Color.fromRGBO(245, 247, 251, 1),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Annual Fees',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppinsbold',
                      ),
                    ),
                    Text(
                      '80,000',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppinsbold',
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 19,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '8th sem tution fee',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(117, 117, 117, 1),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppinsbold'),
                    ),
                    Text(
                      '32,000',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppinsbold',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '8th sem hostel fee',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(117, 117, 117, 1),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppinsbold',
                      ),
                    ),
                    Text(
                      '32,000',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontFamily: 'Poppinsbold',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 17, left: 16, right: 16),
            height: 110,
            width: 339,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
              color: Color.fromRGBO(42, 54, 78, 1),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Paid Fees',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: 'Poppinsbold',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '25,000',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppinsbold',
                        color: Color.fromRGBO(173, 242, 236, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 19,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Due Fees',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: 'Poppinsbold',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '68,000',
                      style: TextStyle(
                        fontFamily: 'Poppinsbold',
                        fontSize: 12,
                        color: Color.fromRGBO(173, 242, 236, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
