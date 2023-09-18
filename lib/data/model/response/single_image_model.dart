// To parse this JSON data, do
//
//     final dayImageModel = dayImageModelFromJson(jsonString);

import 'dart:convert';

DayImageModel dayImageModelFromJson(String str) => DayImageModel.fromJson(json.decode(str));

String dayImageModelToJson(DayImageModel data) => json.encode(data.toJson());

class DayImageModel {
    List<Image> images;

    DayImageModel({
        required this.images,
    });

    factory DayImageModel.fromJson(Map<String, dynamic> json) => DayImageModel(
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))).reversed.toList(),
    );

    Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
    };
}

class Image {
    String id;
    ImageDetails imageDetails;
    List<User> users;
    String comment;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Image({
        required this.id,
        required this.imageDetails,
        required this.users,
        required this.comment,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["_id"],
        imageDetails: ImageDetails.fromJson(json["image_details"]),
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        comment: json["comment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "image_details": imageDetails.toJson(),
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
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

class User {
    String firstName;
    String lastName;
    String email;
    List<String> images;
    DateTime createdAt;
    String id;

    User({
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.images,
        required this.createdAt,
        required this.id,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        images: List<String>.from(json["images"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "images": List<dynamic>.from(images.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
