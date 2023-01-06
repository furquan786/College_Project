import 'package:college_project/Screens/student_screens/notice_image.dart';
import 'package:flutter/material.dart';

class StudentNoticeDetail extends StatefulWidget {
  var description;
  var date;
  var title;
  var id;
  StudentNoticeDetail(
      {required this.id,
      required this.title,
      required this.date,
      required this.description});
  @override
  State<StudentNoticeDetail> createState() => _StudentNoticeDetailState();
}

class _StudentNoticeDetailState extends State<StudentNoticeDetail> {
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
        title: const Text(
          "Notice Details",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppinsbold',
            letterSpacing: 1.2,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 18, left: 31),
                child: Text(
                  "${widget.title}",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Poppinsbold',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoticeImage(imageid: widget.id),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  top: 5,
                ),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(0, 255, 255, 255),
                      offset: Offset(5, 5),
                      blurRadius: 2,
                    ),
                  ],
                ),
                height: 170,
                width: 330,
                child: Image.network(
                    'https://aitsudaipur.herokuapp.com/api/get/photo/notice/${widget.id}',
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    'https://drukasia.com/images/stripes/monk3.jpg',
                    fit: BoxFit.cover,
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 11,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  "${widget.date}".replaceRange(10, 24, ''),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Montserratmediium',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 26,
            ),
            Text(
              'Notice Heading'.toUpperCase(),
              style: const TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(0, 0, 0, 0.489),
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppinsmedium',
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(0, 0, 0, 0.167),
                  width: 2,
                ),
              ),
              width: 300,
              height: 200,
              child: TextField(
                readOnly: true,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 20),
                    border: InputBorder.none,
                    hintText: "${widget.description}"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
