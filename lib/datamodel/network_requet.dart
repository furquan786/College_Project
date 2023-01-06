// import 'package:college_project/datamodel/teacher_details.dart';
// import 'package:flutter/foundation.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class NetworkRequest {
//   static List<Faculties> teacherdata(String parsedata) {
//     var list = jsonDecode(parsedata) as List<dynamic>;
//     List<Faculties> teacherdetails =
//         list.map((model) => Faculties.fromJson(model)).toList();
//     return teacherdetails;
//   }
//
//   static Future<List<Faculties>> fetchdetails() async{
//     var response = await http.get(
//       Uri.parse('https://aitsudaipur.herokuapp.com/api/admin/all/teachers'),
//       headers: {
//         "Content-Type": "application/json",
//       },
//     );
//     if(response.statusCode==200)
//       {
//         return compute(teacherdata,response.body);
//       }
//     else{
//       throw Exception('Can\'t get details');
//     }
//   }
//
// }
