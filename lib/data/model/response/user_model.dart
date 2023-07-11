// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String id;
    String firstName;
    String lastName;
    String email;
    String phone;
    List<Subscription> subscriptions;
    ServerInformation serverInformation;
    RequesterInformation requesterInformation;

    UserModel({
        required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.phone,
        required this.subscriptions,
        required this.serverInformation,
        required this.requesterInformation,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        subscriptions: List<Subscription>.from(json["subscriptions"].map((x) => Subscription.fromJson(x))),
        serverInformation: ServerInformation.fromJson(json["serverInformation"]),
        requesterInformation: RequesterInformation.fromJson(json["requesterInformation"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "subscriptions": List<dynamic>.from(subscriptions.map((x) => x.toJson())),
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
    String action;

    ReceivedParams({
        required this.phone,
        required this.action,
    });

    factory ReceivedParams.fromJson(Map<String, dynamic> json) => ReceivedParams(
        phone: json["phone"],
        action: json["action"],
    );

    Map<String, dynamic> toJson() => {
        "phone": phone,
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

class Subscription {
    Account account;
    String id;
    String name;
    String pppoe;
    String zcrmId;
    String planName;
    int price;
    String type;
    List<String> users;
    bool isDisconnected;
    dynamic wallet;

    Subscription({
        required this.account,
        required this.id,
        required this.name,
        required this.pppoe,
        required this.zcrmId,
        required this.planName,
        required this.price,
        required this.type,
        required this.users,
        required this.isDisconnected,
        this.wallet,
    });

    factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        account: Account.fromJson(json["account"]),
        id: json["_id"],
        name: json["name"],
        pppoe: json["pppoe"],
        zcrmId: json["zcrm_id"],
        planName: json["plan_name"],
        price: json["price"],
        type: json["type"],
        users: List<String>.from(json["users"].map((x) => x)),
        isDisconnected: json["is_disconnected"],
        wallet: json["wallet"] ?? "0",
    );

    Map<String, dynamic> toJson() => {
        "account": account.toJson(),
        "_id": id,
        "name": name,
        "pppoe": pppoe,
        "zcrm_id": zcrmId,
        "plan_name": planName,
        "price": price,
        "type": type,
        "users": List<dynamic>.from(users.map((x) => x)),
        "is_disconnected": isDisconnected,
        "wallet": wallet,
    };
}

class Account {
    String zcrmAccountId;
    String name;

    Account({
        required this.zcrmAccountId,
        required this.name,
    });

    factory Account.fromJson(Map<String, dynamic> json) => Account(
        zcrmAccountId: json["zcrm_account_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "zcrm_account_id": zcrmAccountId,
        "name": name,
    };
}
