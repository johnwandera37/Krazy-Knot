import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String? id;
  final String eventOwner;
  final String eventName;
  final String eventType;
  final String eventVenue;
  final String eventDescription;
  final String eventStatus;
  final String eventStartDate;
  final String eventEndDate;

  Event({
    this.id,
    required this.eventOwner,
    required this.eventName,
    required this.eventType,
    required this.eventVenue,
    required this.eventDescription,
    required this.eventStatus,
    required this.eventStartDate,
    required this.eventEndDate,
  });

  //from json to string
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
    id: json['_id'] as String? ?? '', // Provide a default value if it's null
    eventOwner: json['eventOwner'] as String? ?? '',
    eventName: json['eventName'] as String? ?? '',
    eventType: json['eventType'] as String? ?? '',
    eventVenue: json['eventVenue'] as String? ?? '',
    eventDescription: json['eventDescription'] as String? ?? '',
    eventStatus: json['eventStatus'] as String? ?? '',
    eventStartDate: json['eventStartDate'] as String? ?? '',
    eventEndDate: json['eventEndDate'] as String? ?? '',
    );
  }
  //to json
    Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'eventOwner': eventOwner,
      'eventName': eventName,
      'eventType': eventType,
      'eventVenue': eventVenue,
      'eventDescription': eventDescription,
      'eventStatus': eventStatus,
      'eventStartDate': eventStartDate,
      'eventEndDate': eventEndDate,
    };
  }

   @override
  List<Object?> get props => [
        id,
        eventOwner,
        eventName,
        eventType,
        eventVenue,
        eventDescription,
        eventStatus,
        eventStartDate,
        eventEndDate,
      ];
}


