import '../../utils/export_files.dart';

class AttendeesRepo{
  final ApiClient apiClient;

  AttendeesRepo({required this.apiClient});
  AttendeesModel? attendeesModel;
//Fetch attendees
    Future<Response> getAttendeesApi({
    required String eventId,
  }) async {
    return await apiClient.getWithParamData(
      Constants.baseUrl + Constants.getPeople,
      queryParams: {
        Constants.eventId: eventId,
      },
    );
  }

//Create attendees
   Future<Response> postAttendeesApi(AttendeesCard attendee) async {
    return await apiClient.postData(
      Constants.baseUrl + Constants.addPeople,
      attendee.toJson(),
    );
  }



  //Get link
 Future<Response> getEventLink(eventId) async {
  return await apiClient.getWithParamData(
    Constants.baseUrl + Constants.event + Constants.getLink,
    queryParams: {Constants.eventID: eventId});
  }
  


// Edit attendees list(no end point for this)
  //   Future<Response> editAttendeesApi(Map<String, dynamic> updatedAttendeeData) async {
  //   return await apiClient.putData(
  //     Constants.baseUrl + Constants.editAttendee,
  //     updatedAttendeeData,
  //   );
  // }
}
