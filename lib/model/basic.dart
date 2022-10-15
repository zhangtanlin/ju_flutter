// To parse this JSON data, do
//
//     final modelBasic = modelBasicFromJson(jsonString);

import 'dart:convert';

ModelBasic modelBasicFromJson(String str) =>
    ModelBasic.fromJson(json.decode(str));

String modelBasicToJson(ModelBasic data) => json.encode(data.toJson());

class ModelBasic {
  ModelBasic({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  dynamic data;

  factory ModelBasic.fromJson(Map<String, dynamic> json) => ModelBasic(
        code: json["code"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data,
      };
}
