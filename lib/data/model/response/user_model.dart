// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String firstName;
    String lastName;
    String email;
    List<zImage> images;
    DateTime createdAt;
    String id;

    UserModel({
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.images,
        required this.createdAt,
        required this.id,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        images: List<zImage>.from(json["images"].map((x) => zImage.fromJson(x))).reversed.toList(),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}

class zImage {
    String id;
    ImageDetails imageDetails;
    List<String> users;
    String comment;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    zImage({
        required this.id,
        required this.imageDetails,
        required this.users,
        required this.comment,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory zImage.fromJson(Map<String, dynamic> json) => zImage(
        id: json["_id"],
        imageDetails: ImageDetails.fromJson(json["image_details"]),
        users: List<String>.from(json["users"].map((x) => x)),
        comment: json["comment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "image_details": imageDetails.toJson(),
        "users": List<dynamic>.from(users.map((x) => x)),
        "comment": comment,
        "created_at": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class ImageDetails {
    String fileName;
    String filePath;
    String id;

    ImageDetails({
        required this.fileName,
        required this.filePath,
        required this.id,
    });

    factory ImageDetails.fromJson(Map<String, dynamic> json) => ImageDetails(
        fileName: json["file_name"],
        filePath: json["file_path"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "file_name": fileName,
        "file_path": filePath,
        "_id": id,
    };
}
