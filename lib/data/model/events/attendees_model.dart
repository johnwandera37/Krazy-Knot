import 'package:equatable/equatable.dart';

class Attendees extends Equatable {
  final String eventId;
  final String attendeeName;
  final dynamic attendeePhone;


  Attendees({
    required this.eventId,
    required this.attendeeName,
    required this.attendeePhone,
  });

  //from json to string
  factory Attendees.fromJson(Map<String, dynamic> json) {
    return Attendees(
    eventId: json['eventId'] as String? ?? '',
    attendeeName: json['attendeeName'] as String? ?? '',
    attendeePhone: json['attendeePhone'],
    );
  }
  //to json
    Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'attendeeName': attendeeName,
      'attendeePhone': attendeePhone,
    };
  }

   @override
  List<Object?> get props => [
        eventId,
        attendeeName,
        attendeePhone,
      ];
}


