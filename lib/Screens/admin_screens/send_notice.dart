import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http_parser/http_parser.dart';

class SendNotices extends StatefulWidget {
  var getadmintoken;
  var getadminid;
  SendNotices({required this.getadmintoken, required this.getadminid});
  @override
  State<SendNotices> createState() => _SendNoticesState();
}

class _SendNoticesState extends State<SendNotices> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  String? filename;
  String? path;
  FilePickerResult? result;
  FilePicker? _filePicker;
  bool isloading = false;
  String? whom;
  String? course;
  String? branch;
  String? year;
  var branchlist = ["ALL", "CSE", "EE", "ME", "CE"];
  var whomlist = ["ALL", "faculty", "student"];
  var courselist = ["ALL", "B-TECH", "MCA", "DIPLOMA", "M-TECH"];
  var years = ['ALL', '1', '2', '3', '4'];
  var dio = Dio();

  Future<void> sedingnotice(
    String title,
    String description,
  ) async {
    if (result != null) {
      filename = result!.files.first.name;
    }
    try {
      PlatformFile file = result!.files.first;
      FormData formData = FormData.fromMap(
        {
          'photo': await MultipartFile.fromFile(
            file.path!,
            contentType: MediaType("img", "jpg"),
            filename: filename,
          ),
          'title': title,
          'description': description,
        },
      );
      var response = await dio.post(
        'https://aitsudaipur.herokuapp.com/api/admin/send/notice/$whom/$course/$branch/$year/${widget.getadminid}',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${widget.getadmintoken}',
          },
        ),
      );
      if (response.statusCode == 200) {
        setState(() {
          saving = false;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide.none),
              title: const Text(
                "Success!",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
              content: const Text(
                "Notice sent Successfully",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              actions: [
                TextButton(
                  child: const Text(
                    "Ok",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.red,
                    ),
                  ),
                  onPressed: () {
                    titlecontroller.clear();
                    result!.files.clear();
                    descriptioncontroller.clear();
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          },
        );
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide.none),
                title: const Text(
                  "Oops!",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    height: 1.5,
                  ),
                ),
                // ignore: prefer_const_constructors
                content: Text(
                  "Error Occured",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                actions: [
                  TextButton(
                    child: const Text(
                      "Ok",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    } catch (e) {
      setState(() {
        saving = false;
      });
      print("exception is coming from api ${e}");
    }
  }

  void pickfile() async {
    try {
      setState(() {
        isloading = true;
      });
      path = await FilePicker.platform.getDirectoryPath();
      print("hello path $path");
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

  bool saving = false;

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
            "Notice",
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
      body: ModalProgressHUD(
        inAsyncCall: saving,
        child: SingleChildScrollView(
          child: Container(
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
                  margin: const EdgeInsets.only(),
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  height: 70,
                  width: 300,
                  child: DropdownButton(
                    hint: const Text(
                      'Select whom to send',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(165, 165, 165, 1),
                        letterSpacing: 1.3,
                        fontFamily: 'Poppinslight',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    value: whom,
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
                      fontFamily: 'Poppinslight',
                      fontWeight: FontWeight.w300,
                    ),
                    isExpanded: true,
                    icon: const Padding(
                      padding: EdgeInsets.only(top: 30, right: 6),
                      child: Icon(Icons.keyboard_arrow_down),
                    ),
                    items: whomlist.map(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (String? newvalue) {
                      setState(() {
                        whom = newvalue ?? "";
                      });
                    },
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.only(),
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  height: 70,
                  width: 300,
                  child: DropdownButton(
                    hint: const Text(
                      'Select Course',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(165, 165, 165, 1),
                        letterSpacing: 1.3,
                        fontFamily: 'Poppinslight',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    value: course,
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
                      fontFamily: 'Poppinslight',
                      fontWeight: FontWeight.w300,
                    ),
                    isExpanded: true,
                    icon: const Padding(
                      padding: EdgeInsets.only(top: 30, right: 6),
                      child: Icon(Icons.keyboard_arrow_down),
                    ),
                    items: courselist.map(
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
                          course = newvalue!;
                        },
                      );
                    },
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.only(),
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  height: 70,
                  width: 300,
                  child: DropdownButton(
                    hint: const Text(
                      'Select Branch',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(165, 165, 165, 1),
                        letterSpacing: 1.3,
                        fontFamily: 'Poppinslight',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    value: branch,
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
                      fontFamily: 'Poppinslight',
                      fontWeight: FontWeight.w300,
                    ),
                    isExpanded: true,
                    icon: const Padding(
                      padding: EdgeInsets.only(top: 30, right: 6),
                      child: Icon(Icons.keyboard_arrow_down),
                    ),
                    items: branchlist.map(
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
                          branch = newvalue!;
                        },
                      );
                    },
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.only(),
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  height: 70,
                  width: 300,
                  child: DropdownButton(
                    hint: const Text(
                      'Select Year',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(165, 165, 165, 1),
                        letterSpacing: 1.3,
                        fontFamily: 'Poppinslight',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    value: year,
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
                      fontFamily: 'Poppinslight',
                      fontWeight: FontWeight.w300,
                    ),
                    isExpanded: true,
                    icon: const Padding(
                      padding: EdgeInsets.only(top: 30, right: 6),
                      child: Icon(Icons.keyboard_arrow_down),
                    ),
                    items: years.map(
                      (String year) {
                        return DropdownMenuItem<String>(
                          value: year,
                          child: Text(year),
                        );
                      },
                    ).toList(),
                    onChanged: (String? newvalue) {
                      setState(
                        () {
                          year = newvalue!;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Title',
                      style: TextStyle(
                        color: Color.fromRGBO(139, 139, 139, 1),
                        fontSize: 17,
                        fontFamily: 'Poppinsmedium',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  controller: titlecontroller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Write Title",
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(165, 165, 165, 1),
                      fontSize: 16,
                      fontFamily: 'Montserratlight',
                      fontWeight: FontWeight.w200,
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
                const SizedBox(
                  height: 20,
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
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                TextFormField(
                  controller: descriptioncontroller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your concern here....",
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(165, 165, 165, 1),
                      fontSize: 18,
                      fontFamily: 'Montserratlight',
                      fontWeight: FontWeight.w200,
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
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 18, left: 38),
                    child: Text(
                      'Upload attachments',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Montserratbold',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      pickfile();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 38, top: 13),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(3, 17, 45, 1),
                            Color.fromRGBO(0, 34, 103, 1),
                          ],
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      height: 32,
                      width: 90,
                      child: const Center(
                        child: Text(
                          'Select File',
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
                ),
                isloading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 38,
                            top: 23,
                          ),
                          child: Text(
                            filename == null
                                ? "Not selected File"
                                : "$filename",
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                GestureDetector(
                  onTap: () {
                    try {
                      sedingnotice(
                        titlecontroller.text,
                        descriptioncontroller.text,
                      );
                      setState(() {
                        saving = true;
                      });
                    } catch (e) {
                      print("exception is coming from ${e}");
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 8, top: 53, bottom: 20),
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
                        'Send Notice',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Montserratbold',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
