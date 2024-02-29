// To parse this JSON data, do
//
//     final userdata = userdataFromJson(jsonString);

import 'dart:convert';

Userdata userdataFromJson(String str) => Userdata.fromJson(json.decode(str));

class Userdata {
  String fullName;
  String age;
  String url;

  Userdata({
    required this.fullName,
    required this.age,
    required this.url,
  });

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
        fullName: json["full_name"],
        age: json["age"],
        url: json["url"],
      );
}
