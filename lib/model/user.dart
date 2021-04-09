// To parse this JSON data, do
//
//     final modelUser = modelUserFromJson(jsonString);

import 'dart:convert';

ModelUser modelUserFromJson(String str) => ModelUser.fromJson(json.decode(str));

String modelUserToJson(ModelUser data) => json.encode(data.toJson());

class ModelUser {
    ModelUser({
        this.data,
        this.status,
        this.message,
    });

    Data data;
    int status;
    String message;

    factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
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
        this.list,
        this.total,
    });

    List<ListElement> list;
    int total;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        this.account,
        this.name,
        this.avatar,
        this.phone,
        this.email,
        this.age,
        this.area,
        this.roles,
        this.status,
        this.activateTime,
        this.isFirstLogin,
        this.isLocked,
        this.lockedTime,
        this.isDisabled,
        this.disabledTime,
        this.lastLoginIp,
        this.lastLoginTime,
        this.lastUpdatePasswordTime,
        this.createTime,
        this.department,
        this.firm,
    });

    int id;
    String account;
    String name;
    String avatar;
    Phone phone;
    String email;
    int age;
    String area;
    String roles;
    String status;
    DateTime activateTime;
    String isFirstLogin;
    String isLocked;
    dynamic lockedTime;
    String isDisabled;
    dynamic disabledTime;
    String lastLoginIp;
    dynamic lastLoginTime;
    dynamic lastUpdatePasswordTime;
    DateTime createTime;
    String department;
    String firm;

    factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        account: json["account"],
        name: json["name"],
        avatar: json["avatar"],
        phone: phoneValues.map[json["phone"]],
        email: json["email"],
        age: json["age"] == null ? null : json["age"],
        area: json["area"],
        roles: json["roles"],
        status: json["status"],
        activateTime: DateTime.parse(json["activate_time"]),
        isFirstLogin: json["is_first_login"],
        isLocked: json["is_locked"],
        lockedTime: json["locked_time"],
        isDisabled: json["is_disabled"],
        disabledTime: json["disabled_time"],
        lastLoginIp: json["last_login_ip"],
        lastLoginTime: json["last_login_time"],
        lastUpdatePasswordTime: json["last_update_password_time"],
        createTime: DateTime.parse(json["create_time"]),
        department: json["department"],
        firm: json["firm"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "account": account,
        "name": name,
        "avatar": avatar,
        "phone": phoneValues.reverse[phone],
        "email": email,
        "age": age == null ? null : age,
        "area": area,
        "roles": roles,
        "status": status,
        "activate_time": activateTime.toIso8601String(),
        "is_first_login": isFirstLogin,
        "is_locked": isLocked,
        "locked_time": lockedTime,
        "is_disabled": isDisabled,
        "disabled_time": disabledTime,
        "last_login_ip": lastLoginIp,
        "last_login_time": lastLoginTime,
        "last_update_password_time": lastUpdatePasswordTime,
        "create_time": createTime.toIso8601String(),
        "department": department,
        "firm": firm,
    };
}

enum Phone { THE_12425632566, THE_15235633333, EMPTY }

final phoneValues = EnumValues({
    "": Phone.EMPTY,
    "12425632566": Phone.THE_12425632566,
    "15235633333": Phone.THE_15235633333
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
