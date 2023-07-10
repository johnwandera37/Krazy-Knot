// To parse this JSON data, do
//
//     final errorResponse = errorResponseFromJson(jsonString);

import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) => ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
    String error;
    ServerInformation2 serverInformation;
    RequesterInformation2 requesterInformation;

    ErrorResponse({
        required this.error,
        required this.serverInformation,
        required this.requesterInformation,
    });

    factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        error: json["error"],
        serverInformation: ServerInformation2.fromJson(json["serverInformation"]),
        requesterInformation: RequesterInformation2.fromJson(json["requesterInformation"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "serverInformation": serverInformation.toJson(),
        "requesterInformation": requesterInformation.toJson(),
    };
}

class RequesterInformation2 {
    String id;
    String fingerprint;
    String messageId;
    String remoteIp;
    ReceivedParams2 receivedParams;

    RequesterInformation2({
        required this.id,
        required this.fingerprint,
        required this.messageId,
        required this.remoteIp,
        required this.receivedParams,
    });

    factory RequesterInformation2.fromJson(Map<String, dynamic> json) => RequesterInformation2(
        id: json["id"],
        fingerprint: json["fingerprint"],
        messageId: json["messageId"],
        remoteIp: json["remoteIP"],
        receivedParams: ReceivedParams2.fromJson(json["receivedParams"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fingerprint": fingerprint,
        "messageId": messageId,
        "remoteIP": remoteIp,
        "receivedParams": receivedParams.toJson(),
    };
}

class ReceivedParams2 {
    String phone;
    String password;
    String action;

    ReceivedParams2({
        required this.phone,
        required this.password,
        required this.action,
    });

    factory ReceivedParams2.fromJson(Map<String, dynamic> json) => ReceivedParams2(
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

class ServerInformation2 {
    String serverName;
    String apiVersion;
    int requestDuration;
    int currentTime;

    ServerInformation2({
        required this.serverName,
        required this.apiVersion,
        required this.requestDuration,
        required this.currentTime,
    });

    factory ServerInformation2.fromJson(Map<String, dynamic> json) => ServerInformation2(
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
