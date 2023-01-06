import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountantHomeScreen extends StatefulWidget {
  @override
  State<AccountantHomeScreen> createState() => _AccountantHomeScreenState();
}

class _AccountantHomeScreenState extends State<AccountantHomeScreen> {
  String? filename;
  FilePickerResult? result;
  bool isloading = false;
  var dio = Dio();
  var accounttoken;
  @override
  void initState() {
    getaccounttoken();
    super.initState();
  }

  Future<void> getaccounttoken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      accounttoken = pref.getString('token');
    });
  }

  Future<void> uploadfile() async {
    try {
      PlatformFile file = result!.files.first;
      FormData formData = FormData.fromMap(
        {
          'file': await MultipartFile.fromFile(
            file.path!,
            contentType: MediaType('img', 'jpg'),
            filename: filename,
          ),
        },
      );

      var response = await dio.post(
        'https://aitsudaipur.herokuapp.com/api/faculty/upload/student',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $accounttoken',
          },
        ),
      );
      print("response id ${response.statusCode}");
      if (response.statusCode == 200) {
        setState(() {
          uploading = false;
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
        setState(() {
          uploading = false;
        });
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
                  "File Format not",
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
        uploading = false;
      });
      print('exception is coming $e'.toString());
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
      setState(() {
        uploading = false;
      });
      print(e);
    }
  }

  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(top: 25, left: 10),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        leadingWidth: 40,
        backgroundColor: Color.fromRGBO(25, 48, 76, 1),
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text(
              "Account",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: SizedBox(),
        ),
      ),
      backgroundColor: Color.fromRGBO(244, 244, 247, 1),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: uploading,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 22, top: 33),
                  child: Text(
                    "Upload attachments",
                    style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 1.6,
                      color: Color.fromRGBO(1, 37, 81, 1),
                      fontFamily: 'Ralewaybold',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                width: 309,
                height: 157,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 8,
                        offset: Offset(2, 2))
                  ],
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          pickfile();
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 17, top: 13),
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
                                fontFamily: 'Ralewaybold',
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
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    uploading = true;
                  });
                  uploadfile();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 8, bottom: 20),
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
                      'Upload File',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Ralewaybold',
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
