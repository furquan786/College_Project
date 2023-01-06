// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    required this.name,
    required this.email,
    required this.password,
    required this.mno,
    required this.scholarNumber,
    required this.course,
    required this.branchName,
    required this.dob,
  });

  String name;
  String email;
  String password;
  int mno;
  int scholarNumber;
  String course;
  String branchName;
  String dob;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    mno: int.parse(json["mno"] as String),
    scholarNumber: int.parse(json["scholar_number"] as String),
    course: json["course"],
    branchName: json["branch_name"],
    dob: json["dob"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "mno": mno,
    "scholar_number": scholarNumber,
    "course": course,
    "branch_name": branchName,
    "dob": dob,
  };
}







DataModel admindataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String admindataModelToJson(DataModel data) => json.encode(data.toJson());

class AdminDataModel {
  AdminDataModel({
    required this.email,
    required this.password,
    required this.mno,
  });

  String email;
  String password;
  int mno;

  factory AdminDataModel.fromJson(Map<String, dynamic> json) => AdminDataModel(
    email: json["email"],
    password: json["password"],
    mno: json["mno"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "mno": mno,
  };
}

