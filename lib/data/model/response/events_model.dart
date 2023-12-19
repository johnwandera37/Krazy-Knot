
import 'dart:convert';

EventModel supportModelFromJson(String str) => EventModel.fromJson(json.decode(str));

String supportModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel{
  List<Event> events;
  EventModel({
    required this.events,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
    );

 Map<String, dynamic> toJson() =>{
   "events": List<dynamic>.from(events.map((x) => x.toJson())),
 };
}

class Event{
  final String id;
  final String eventOwner;
  final String eventName;
  final String eventType;
  final String eventVenue;
  final String eventDescription;
  final String eventStatus;
  final String eventStartDate;
  final String eventEndDate;

  Event({
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

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json['_id'],
    eventOwner: json['eventOwner'],
    eventName: json['eventName'],
    eventType: json['eventType'],
    eventVenue: json['eventVenue'],
    eventDescription: json['eventDescription'],
    eventStatus: json['eventStatus'],
    eventStartDate: json['eventStartDate'],
    eventEndDate: json['eventEndDate'],
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
      'eventStartDate': eventStartDate,
      'eventEndDate': eventEndDate,
    };
}