
import 'dart:convert';

EventModel eventModelFromJson(String str) => EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel data) => json.encode(data.toJson());
// jsonEncode(event.toJson())

class EventModel{
  List<EventCard> events;
  EventModel({
    required this.events,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    events: List<EventCard>.from(json["events"].map((x) => EventCard.fromJson(x))),
    );

 Map<String, dynamic> toJson() =>{
   "events": List<dynamic>.from(events.map((x) => x.toJson())),
 };
}

class EventCard{
  final String id;
  final String eventOwner;
  final String eventName;
  final String eventType;
  final String eventVenue;
  final String eventDescription;
  final String eventStatus;
  final DateTime eventStartDate;
  final DateTime eventEndDate;

  EventCard({
    required this.id,
    required this.eventOwner,
    required this.eventName,
    required this.eventType,
    required this.eventVenue,
    required this.eventDescription,
    required this.eventStatus,
    required this.eventStartDate,
    required this.eventEndDate,
  });

  factory EventCard.fromJson(Map<String, dynamic> json) => EventCard(
     id: json['_id'] ?? '',
    eventOwner: json['eventOwner'] ?? '',
    eventName: json['eventName'] ?? '',
    eventType: json['eventType'] ?? '',
    eventVenue: json['eventVenue'] ?? '',
    eventDescription: json['eventDescription'] ?? '',
    eventStatus: json['eventStatus'] ?? '',
    eventStartDate: json['eventStartDate'] != null ? DateTime.parse(json['eventStartDate']): DateTime.now(),
    eventEndDate: json['eventEndDate'] != null ? DateTime.parse(json['eventEndDate']): DateTime.now(),
    );
  
    Map<String, dynamic> toJson() =>
    {
      '_id': id,
      'eventOwner': eventOwner,
      'eventName': eventName,
      'eventType': eventType,
      'eventVenue': eventVenue,
      'eventDescription': eventDescription,
      'eventStatus': eventStatus,
      'eventStartDate': eventStartDate.toIso8601String(),
      'eventEndDate': eventEndDate.toIso8601String(),
    };
}