// To parse this JSON data, do
//
//     final basic = basicFromJson(jsonString);

import 'dart:convert';

Basic basicFromJson(String str) => Basic.fromJson(json.decode(str));

String basicToJson(Basic data) => json.encode(data.toJson());

class Basic {
  Basic({
    this.data,
    this.status,
    this.message,
  });

  dynamic data;
  int status;
  String message;

  factory Basic.fromJson(Map<String, dynamic> json) => Basic(
        data: json["data"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "status": status,
        "message": message,
      };
}
