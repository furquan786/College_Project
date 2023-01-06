import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class NoticeImage extends StatefulWidget {
  var imageid;
  NoticeImage({required this.imageid});
  @override
  State<NoticeImage> createState() => _NoticeImageState();
}

class _NoticeImageState extends State<NoticeImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(54, 0, 0, 0),
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: PhotoView(
            errorBuilder: (context, error, stackTrace) {
              return Image.network(
                'https://drukasia.com/images/stripes/monk3.jpg',
                fit: BoxFit.cover,
              );
            },
            imageProvider: NetworkImage(
                'https://aitsudaipur.herokuapp.com/api/get/photo/notice/${widget.imageid}'),
          ),
        ),
      ),
    );
  }
}









// Container(
          // padding:
          //     const EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 10),
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
//           child: Image.network(
//               'https://aitsudaipur.herokuapp.com/api/get/photo/notice/${widget.imageid}',
//               // fit: BoxFit.contain,
//               height: 280,
//               width: 20,
//               filterQuality: FilterQuality.high,
          //     errorBuilder: (context, error, stackTrace) {
          //   return Image.network(
          //     'https://drukasia.com/images/stripes/monk3.jpg',
          //     fit: BoxFit.cover,
          //   );
          // }),
//         ),
     
     