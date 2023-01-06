import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class StudentComplain extends StatefulWidget {
  @override
  State<StudentComplain> createState() => _StudentComplainState();
}

class _StudentComplainState extends State<StudentComplain> {
  String? filename;
  bool selected = false;
  bool selected1 = false;
  bool selected2 = false;
  bool selected3 = false;
  bool selected4 = false;
  bool selected5 = false;

  FilePickerResult? result;
  bool isloading = false;
  String dropdownvalue = "B-TECH";
  String dropdownvalue1 = "CSE";
  String value2 = "EVENTS";
  var branch = ["CSE", "EE", "ME", "CE"];
  var notice = ["EVENTS", "APPLICATION", "WHY"];
  var item = ["B-TECH", "MCA", "DIPLOMA", "M-TECH"];

  void pickfile() async {
    try {
      setState(() {
        isloading = true;
      });

      result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );
      if (result != null) {
        filename = result!.files.first.name;
      }

      setState(() {
        isloading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            "Complain",
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              letterSpacing: 1.2,
              fontFamily: 'Montserratbold',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(252, 252, 252, 1),
      body: Container(
        margin: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(210, 210, 210, 1),
              blurRadius: 10,
              offset: Offset(-2, 5),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              margin: const EdgeInsets.only(top: 2),
              padding: const EdgeInsets.only(left: 10, top: 3),
              height: 70,
              width: 300,
              child: DropdownButton(
                value: dropdownvalue,
                underline: Container(
                  margin: const EdgeInsets.only(right: 8),
                  height: 1,
                  color: Colors.black12,
                ),
                menuMaxHeight: 100,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color.fromRGBO(165, 165, 165, 1),
                  letterSpacing: 1.3,
                  fontFamily: 'Poppinsmedium',
                  fontWeight: FontWeight.normal,
                ),
                isExpanded: true,
                icon: const Padding(
                  padding: EdgeInsets.only(top: 30, right: 6),
                  child: Icon(Icons.keyboard_arrow_down),
                ),
                items: item.map(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
                onChanged: (String? newvalue) {
                  setState(() {
                    dropdownvalue = newvalue!;
                  });
                },
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              margin: const EdgeInsets.only(top: 2),
              padding: const EdgeInsets.only(left: 10, top: 3),
              height: 70,
              width: 300,
              child: DropdownButton(
                value: dropdownvalue1,
                underline: Container(
                  margin: const EdgeInsets.only(right: 8),
                  height: 1,
                  color: Colors.black12,
                ),
                menuMaxHeight: 100,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(165, 165, 165, 1),
                  letterSpacing: 1.3,
                  fontFamily: 'Poppinsmedium',
                  fontWeight: FontWeight.normal,
                ),
                isExpanded: true,
                icon: const Padding(
                  padding: EdgeInsets.only(top: 30, right: 6),
                  child: Icon(Icons.keyboard_arrow_down),
                ),
                items: branch.map(
                  (String branch) {
                    return DropdownMenuItem<String>(
                      value: branch,
                      child: Text(branch),
                    );
                  },
                ).toList(),
                onChanged: (String? newvalue) {
                  setState(
                    () {
                      dropdownvalue1 = newvalue!;
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Complain Type',
                  style: TextStyle(
                    color: Color.fromRGBO(139, 139, 139, 1),
                    fontSize: 17,
                    fontFamily: 'Poppinsmedium',
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = true;
                        selected1 = false;
                        selected2 = false;
                        selected3 = false;
                        selected4 = false;
                      });
                    },
                    child: Container(
                      height: 26,
                      width: 70,
                      decoration: BoxDecoration(
                        color: selected
                            ? const Color.fromRGBO(0, 91, 152, 1)
                            : Colors.white,
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(6),
                        ),
                        border: Border.all(
                          color: selected
                              ? Colors.transparent
                              : const Color.fromRGBO(0, 91, 152, 1),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "bus delay",
                          style: TextStyle(
                            fontSize: 9,
                            color: selected
                                ? Colors.white
                                : const Color.fromRGBO(0, 91, 152, 1),
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppinsmedium',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected1 = true;
                        selected = false;
                        selected2 = false;
                        selected3 = false;
                        selected4 = false;
                      });
                    },
                    child: Container(
                      height: 26,
                      width: 70,
                      decoration: BoxDecoration(
                        color: selected1
                            ? const Color.fromRGBO(0, 91, 152, 1)
                            : Colors.white,
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(6),
                        ),
                        border: Border.all(
                          color: selected1
                              ? Colors.transparent
                              : const Color.fromRGBO(0, 91, 152, 1),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "exam",
                          style: TextStyle(
                              fontSize: 9,
                              color: selected1
                                  ? Colors.white
                                  : const Color.fromRGBO(0, 91, 152, 1),
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppinsmedium'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected2 = true;
                        selected = false;
                        selected1 = false;
                        selected3 = false;
                        selected4 = false;
                      });
                    },
                    child: Container(
                      height: 26,
                      width: 70,
                      decoration: BoxDecoration(
                        color: selected2
                            ? const Color.fromRGBO(0, 91, 152, 1)
                            : Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(6),
                        ),
                        border: Border.all(
                          color: selected2
                              ? Colors.transparent
                              : const Color.fromRGBO(0, 91, 152, 1),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "teacher",
                          style: TextStyle(
                              fontSize: 9,
                              color: selected2
                                  ? Colors.white
                                  : const Color.fromRGBO(0, 91, 152, 1),
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Poppinsmedium'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected3 = true;
                        selected = false;
                        selected1 = false;
                        selected2 = false;
                        selected4 = false;
                      });
                    },
                    child: Container(
                      height: 26,
                      width: 70,
                      decoration: BoxDecoration(
                        color: selected3
                            ? const Color.fromRGBO(0, 91, 152, 1)
                            : Colors.white,
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(6),
                        ),
                        border: Border.all(
                          color: selected3
                              ? Colors.transparent
                              : const Color.fromRGBO(0, 91, 152, 1),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "schedule",
                          style: TextStyle(
                            fontSize: 9,
                            color: selected3
                                ? Colors.white
                                : const Color.fromRGBO(0, 91, 152, 1),
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppinsmedium',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected3 = false;
                        selected = false;
                        selected1 = false;
                        selected2 = false;
                        selected4 = true;
                      });
                    },
                    child: Container(
                      height: 26,
                      width: 70,
                      decoration: BoxDecoration(
                        color: selected4
                            ? const Color.fromRGBO(0, 91, 152, 1)
                            : Colors.white,
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(6),
                        ),
                        border: Border.all(
                          color: selected4
                              ? Colors.transparent
                              : const Color.fromRGBO(0, 91, 152, 1),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "students",
                          style: TextStyle(
                            fontSize: 9,
                            color: selected4
                                ? Colors.white
                                : const Color.fromRGBO(0, 91, 152, 1),
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppinsmedium',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                ],
              ),
            ),
//row implement krna hai

            const SizedBox(
              height: 50,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Write short description',
                  style: TextStyle(
                    color: Color.fromRGBO(139, 139, 139, 1),
                    fontSize: 17,
                    fontFamily: 'Poppinsmedium',
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter your concern here....",
                hintStyle: TextStyle(
                  color: Color.fromRGBO(165, 165, 165, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppinsmedium',
                ),
                contentPadding: EdgeInsets.only(
                  left: 20,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 8),
              height: 1,
              color: const Color.fromRGBO(222, 222, 222, 1),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 6.5,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(left: 8, top: 83),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(42, 54, 48, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                height: 48,
                width: 261,
                child: const Center(
                  child: Text(
                    'Raise Complain',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppinsbold',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
