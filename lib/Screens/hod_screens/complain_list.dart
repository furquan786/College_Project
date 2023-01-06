import 'package:flutter/material.dart';

class ComplainList extends StatefulWidget {
  const ComplainList({Key? key}) : super(key: key);

  @override
  State<ComplainList> createState() => _ComplainListState();
}

class _ComplainListState extends State<ComplainList> {
  ScrollController controller = ScrollController();
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
        title: const Padding(
          padding: EdgeInsets.only(),
          child: Text(
            "Complain List",
            style: TextStyle(
              fontFamily: 'Montserratbold',
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 31,
                right: 52,
              ),
              color: const Color.fromRGBO(39, 76, 120, 1),
              height: 54,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Date',
                    style: TextStyle(
                      fontFamily: 'Montserratmediium',
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Isssue',
                    style: TextStyle(
                      fontFamily: 'Montserratmediium',
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    'complain Narrative',
                    style: TextStyle(
                      fontFamily: 'Montserratmediium',
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 359,
              constraints: const BoxConstraints(
                maxHeight: double.infinity,
              ),
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Column(
                children: [
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 1.28,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      controller: controller,
                      shrinkWrap: true,
                      itemCount: 32,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 8,
                                  width: 8,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),
                                ),
                                const Text(
                                  '12/02/2022',
                                  style: TextStyle(
                                    fontFamily: 'Poppinsmedium',
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const Text(
                                  'exam',
                                  style: TextStyle(
                                    fontFamily: 'Poppinsmedium',
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const Text(
                                  'all student herby inform that....',
                                  style: TextStyle(
                                    fontFamily: 'Montserratbold',
                                    fontSize: 13,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
