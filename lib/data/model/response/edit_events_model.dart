class EditEventCard {
  final String eventId;
  String eventName;
  String eventOwner;
  String eventType;
  String eventVenue;
  String eventDescription;
  String eventStatus;
  DateTime eventStartDate;
  DateTime eventEndDate;

  EditEventCard({
    required this.eventId,
    required this.eventName,
    required this.eventOwner,
    required this.eventType,
    required this.eventVenue,
    required this.eventDescription,
    required this.eventStatus,
    required this.eventStartDate,
    required this.eventEndDate,
  });

  // Convert the Event object to a map
  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'eventName': eventName,
      'eventOwner': eventOwner,
      'eventType': eventType,
      'eventVenue': eventVenue,
      'eventDescription': eventDescription,
      'eventStatus': eventStatus,
      'eventStartDate': eventStartDate.toIso8601String(),
      'eventEndDate': eventEndDate.toIso8601String(),
    };
  }
}

class EditEventStatus {
String eventStatus;
final String eventId;

  EditEventStatus({
    required this.eventId,
    required this.eventStatus,
  });

  // Convert the Event object to a map
  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'eventStatus': eventStatus
    };
  }
}