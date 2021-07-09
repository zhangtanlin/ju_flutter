// To parse this JSON data, do
//
//     final modelConfig = modelConfigFromJson(jsonString);

import 'dart:convert';

ModelConfig modelConfigFromJson(String str) =>
    ModelConfig.fromJson(json.decode(str));

String modelConfigToJson(ModelConfig data) => json.encode(data.toJson());

class ModelConfig {
  ModelConfig({
    this.data,
    this.status,
    this.message,
  });

  Data data;
  int status;
  String message;

  factory ModelConfig.fromJson(Map<String, dynamic> json) => ModelConfig(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
      };
}

class Data {
  Data({
    this.version,
    this.userInfo,
    this.config,
    this.ads,
  });

  Version version;
  UserInfo userInfo;
  Config config;
  List<Ad> ads;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        version: Version.fromJson(json["version"]),
        userInfo: UserInfo.fromJson(json["userInfo"]),
        config: Config.fromJson(json["config"]),
        ads: List<Ad>.from(json["ads"].map((x) => Ad.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "version": version.toJson(),
        "userInfo": userInfo.toJson(),
        "config": config.toJson(),
        "ads": List<dynamic>.from(ads.map((x) => x.toJson())),
      };
}

class Ad {
  Ad({
    this.id,
    this.name,
    this.type,
    this.src,
    this.link,
    this.status,
    this.explanation,
  });

  int id;
  String name;
  int type;
  String src;
  String link;
  int status;
  String explanation;

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        src: json["src"],
        link: json["link"],
        status: json["status"],
        explanation: json["explanation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "src": src,
        "link": link,
        "status": status,
        "explanation": explanation,
      };
}

class Config {
  Config({
    this.id,
    this.devApi,
    this.api,
    this.githubApi,
    this.tfApi,
    this.tfGithubApi,
    this.imageHost,
    this.uploadImageKey,
    this.uploadImageUrl,
    this.uploadVideoKey,
    this.uploadVideoUrl,
  });

  int id;
  String devApi;
  String api;
  String githubApi;
  String tfApi;
  String tfGithubApi;
  String imageHost;
  String uploadImageKey;
  String uploadImageUrl;
  String uploadVideoKey;
  String uploadVideoUrl;

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        id: json["id"],
        devApi: json["devApi"],
        api: json["api"],
        githubApi: json["githubApi"],
        tfApi: json["tfApi"],
        tfGithubApi: json["tfGithubApi"],
        imageHost: json["imageHost"],
        uploadImageKey: json["uploadImageKey"],
        uploadImageUrl: json["uploadImageUrl"],
        uploadVideoKey: json["uploadVideoKey"],
        uploadVideoUrl: json["uploadVideoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "devApi": devApi,
        "api": api,
        "githubApi": githubApi,
        "tfApi": tfApi,
        "tfGithubApi": tfGithubApi,
        "imageHost": imageHost,
        "uploadImageKey": uploadImageKey,
        "uploadImageUrl": uploadImageUrl,
        "uploadVideoKey": uploadVideoKey,
        "uploadVideoUrl": uploadVideoUrl,
      };
}

class UserInfo {
  UserInfo();

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo();

  Map<String, dynamic> toJson() => {};
}

class Version {
  Version({
    this.id,
    this.version,
    this.downloadUrl,
    this.description,
    this.stronger,
    this.announcement,
    this.status,
    this.createTime,
  });

  int id;
  String version;
  String downloadUrl;
  String description;
  int stronger;
  String announcement;
  String status;
  DateTime createTime;

  factory Version.fromJson(Map<String, dynamic> json) => Version(
        id: json["id"],
        version: json["version"],
        downloadUrl: json["downloadUrl"],
        description: json["description"],
        stronger: json["stronger"],
        announcement: json["announcement"],
        status: json["status"],
        createTime: DateTime.parse(json["create_time"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "version": version,
        "downloadUrl": downloadUrl,
        "description": description,
        "stronger": stronger,
        "announcement": announcement,
        "status": status,
        "create_time": createTime.toIso8601String(),
      };
}
