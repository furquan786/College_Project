import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HodSendNotices extends StatefulWidget {
  var hodtoken;
  var hodid;
  HodSendNotices({required this.hodid, required this.hodtoken});
  @override
  State<HodSendNotices> createState() => _HodSendNoticesState();
}

class _HodSendNoticesState extends State<HodSendNotices> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  String? filename;
  FilePickerResult? result;
  bool isloading = false;
  String dropdownvalue = "B-TECH";
  String dropdownvalue1 = "CSE";
  String value2 = "EVENTS";
  var branch = ["CSE", "EE", "ME", "CE"];
  var notice = ["EVENTS", "APPLICATION", "WHY"];
  var item = ["B-TECH", "MCA", "DIPLOMA", "M-TECH"];
  var dio = Dio();
  bool saving = false;

  Future<void> sedingnotice(
    String title,
    String description,
  ) async {
    if (result != null) {
      filename = result!.files.first.name;
    }
    PlatformFile file = result!.files.first;
    try {
      FormData formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(
          file.path!,
          filename: filename,
        ),
        'title': title,
        'description': description,
      });
      var response = await dio.post(
        'https://aitsudaipur.herokuapp.com/api/faculty/send/notice/student/${widget.hodid}',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${widget.hodtoken}',
          },
        ),
      );
      print("$response");
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
                  "File Uploaded Successfully",
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
                      result!.files.clear();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
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
                content: const Text(
                  "File Uploaded Unsuccessfully",
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
                      result!.files.clear();
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
      print(e);
    }
  }

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
      backgroundColor: Color.fromRGBO(252, 252, 252, 1),
      body: ModalProgressHUD(
        inAsyncCall: saving,
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
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(left: 10, top: 6),
                height: 70,
                width: 300,
                child: DropdownButton(
                  value: dropdownvalue,
                  underline: Container(
                    margin: EdgeInsets.only(right: 8),
                    height: 1,
                    color: Colors.black12,
                  ),
                  menuMaxHeight: 100,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color.fromRGBO(165, 165, 165, 1),
                    letterSpacing: 1.3,
                    fontFamily: 'Montserratlight',
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
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.only(left: 10, top: 6),
                height: 70,
                width: 300,
                child: DropdownButton(
                  value: dropdownvalue1,
                  underline: Container(
                    margin: EdgeInsets.only(right: 8),
                    height: 1,
                    color: Colors.black12,
                  ),
                  menuMaxHeight: 100,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(165, 165, 165, 1),
                    letterSpacing: 1.3,
                    fontFamily: 'Montserratlight',
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
                height: 20,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Title',
                    style: TextStyle(
                      color: Color.fromRGBO(139, 139, 139, 1),
                      fontSize: 17,
                      fontFamily: 'Poppinsbold',
                      fontWeight: FontWeight.bold,
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
                    fontFamily: 'Poppinslight',
                    fontWeight: FontWeight.normal,
                  ),
                  contentPadding: EdgeInsets.only(
                    left: 20,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 8),
                height: 1,
                color: Color.fromRGBO(222, 222, 222, 1),
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Write short description',
                    style: TextStyle(
                      color: Color.fromRGBO(139, 139, 139, 1),
                      fontSize: 17,
                      fontFamily: 'Poppinsbold',
                      fontWeight: FontWeight.bold,
                    ),
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
                    fontFamily: 'Poppinslight',
                    fontWeight: FontWeight.normal,
                  ),
                  contentPadding: EdgeInsets.only(
                    left: 20,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 8),
                height: 1,
                color: Color.fromRGBO(222, 222, 222, 1),
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
                    margin: EdgeInsets.only(left: 38, top: 13),
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
                          fontFamily: 'Montserratbold',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              isloading
                  ? Center(
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
                          filename == null ? "Not selected File" : "$filename",
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
                  print("i got pressed");
                  setState(() {
                    saving = true;
                  });
                  sedingnotice(
                      titlecontroller.text, descriptioncontroller.text);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 8, top: 83),
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
    );
  }
}
