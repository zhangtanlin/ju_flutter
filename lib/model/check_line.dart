// To parse this JSON data, do
//
//     final modelCheckLine = modelCheckLineFromJson(jsonString);

import 'dart:convert';

ModelCheckLine modelCheckLineFromJson(String str) => ModelCheckLine.fromJson(json.decode(str));

String modelCheckLineToJson(ModelCheckLine data) => json.encode(data.toJson());

class ModelCheckLine {
    ModelCheckLine({
        this.data,
        this.status,
        this.message,
    });

    ModelCheckLineData data;
    int status;
    String message;

    factory ModelCheckLine.fromJson(Map<String, dynamic> json) => ModelCheckLine(
        data: ModelCheckLineData.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
    };
}

class ModelCheckLineData {
    ModelCheckLineData({
        this.code,
        this.data,
        this.message,
    });

    int code;
    DataData data;
    String message;

    factory ModelCheckLineData.fromJson(Map<String, dynamic> json) => ModelCheckLineData(
        code: json["code"],
        data: DataData.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
        "message": message,
    };
}

class DataData {
    DataData({
        this.list,
        this.total,
    });

    List<ListElement> list;
    int total;

    factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "total": total,
    };
}

class ListElement {
    ListElement({
        this.id,
        this.name,
        this.type,
        this.address,
    });

    int id;
    String name;
    int type;
    String address;

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "address": address,
    };
}
