// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String id;
    String email;
    String firstName;
    String lastName;
    String phone;
    String token;
    ServerInformation serverInformation;
    RequesterInformation requesterInformation;

    UserModel({
        required this.id,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.phone,
        required this.token,
        required this.serverInformation,
        required this.requesterInformation,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
        token: json["token"],
        serverInformation: ServerInformation.fromJson(json["serverInformation"]),
        requesterInformation: RequesterInformation.fromJson(json["requesterInformation"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "token": token,
        "serverInformation": serverInformation.toJson(),
        "requesterInformation": requesterInformation.toJson(),
    };
}

class RequesterInformation {
    String id;
    String fingerprint;
    String messageId;
    String remoteIp;
    ReceivedParams receivedParams;

    RequesterInformation({
        required this.id,
        required this.fingerprint,
        required this.messageId,
        required this.remoteIp,
        required this.receivedParams,
    });

    factory RequesterInformation.fromJson(Map<String, dynamic> json) => RequesterInformation(
        id: json["id"],
        fingerprint: json["fingerprint"],
        messageId: json["messageId"],
        remoteIp: json["remoteIP"],
        receivedParams: ReceivedParams.fromJson(json["receivedParams"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fingerprint": fingerprint,
        "messageId": messageId,
        "remoteIP": remoteIp,
        "receivedParams": receivedParams.toJson(),
    };
}

class ReceivedParams {
    String phone;
    String password;
    String action;

    ReceivedParams({
        required this.phone,
        required this.password,
        required this.action,
    });

    factory ReceivedParams.fromJson(Map<String, dynamic> json) => ReceivedParams(
        phone: json["phone"],
        password: json["password"],
        action: json["action"],
    );

    Map<String, dynamic> toJson() => {
        "phone": phone,
        "password": password,
        "action": action,
    };
}

class ServerInformation {
    String serverName;
    String apiVersion;
    int requestDuration;
    int currentTime;

    ServerInformation({
        required this.serverName,
        required this.apiVersion,
        required this.requestDuration,
        required this.currentTime,
    });

    factory ServerInformation.fromJson(Map<String, dynamic> json) => ServerInformation(
        serverName: json["serverName"],
        apiVersion: json["apiVersion"],
        requestDuration: json["requestDuration"],
        currentTime: json["currentTime"],
    );

    Map<String, dynamic> toJson() => {
        "serverName": serverName,
        "apiVersion": apiVersion,
        "requestDuration": requestDuration,
        "currentTime": currentTime,
    };
}
