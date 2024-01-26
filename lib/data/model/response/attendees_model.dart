
import 'dart:convert';

import 'package:photomanager/utils/export_files.dart';

class AttendeesModel{
  List<AttendeesCard> attendee;
  AttendeesModel({
    required this.attendee,
  });

  factory AttendeesModel.fromJson(Map<String, dynamic> json) => AttendeesModel(
    attendee: List<AttendeesCard>.from(json["guests"].map((x) => AttendeesCard.fromJson(x))),
    );

 Map<String, dynamic> toJson() =>{
   "guests": List<dynamic>.from(attendee.map((x) => x.toJson())),
 };
}


class AttendeesCard{
  final String eventId;
  final String attendeeName;
  final String attendeePhone;

  const AttendeesCard({
    required this.eventId,
    required this.attendeeName,
    required this.attendeePhone,
  });

  //from json to string
  factory AttendeesCard.fromJson(Map<String, dynamic> json) {
    return AttendeesCard(
    eventId: json['_id'] ?? '',//eventId
    attendeeName: json['attendeeName'] ?? '',
    attendeePhone: json['attendeePhone'] ?? '',
    );
  }
  //to json
    Map<String, dynamic> toJson() {
    return {
      '_id': eventId,
      'attendeeName': attendeeName,
      'attendeePhone': attendeePhone,
    };
  }
}


class AttendeesLinkModel{
  List<AttendeesLink> link;
  AttendeesLinkModel({
    required this.link,
  });
  // factory AttendeesLinkModel.fromJson(Map<String, dynamic> json) => AttendeesLinkModel(
  //   link: List<AttendeesLink>.from(json["eventLink"].map((x) => AttendeesLink.fromJson(x))),
  //   );
    factory AttendeesLinkModel.fromJson(Map<String, dynamic> json) => AttendeesLinkModel(
  link: [AttendeesLink.fromJson(json)],
);

}

class AttendeesLink{
  final String eventLink;

  const AttendeesLink({
    required this.eventLink,
  });

  //from json to string
  factory AttendeesLink.fromJson(Map<String, dynamic> json) {
    return AttendeesLink(
    eventLink: json['eventLink'] ?? '',
    );
  }
}




