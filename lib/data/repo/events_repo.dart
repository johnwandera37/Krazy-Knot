import '../../utils/export_files.dart';

class EventsRepo{
  final ApiClient apiClient;

  EventsRepo({required this.apiClient});
  EventModel? eventModel;
//Fetch events
    Future<Response> getEventsApi({
    required String eventOwner,
  }) async {
    return await apiClient.getWithParamData(
      Constants.baseUrl + Constants.getEvents,
      queryParams: {
        Constants.eventOwner: eventOwner,
      },
    );
  }

//Create events
   Future<Response> postEventsApi(EventCard event) async {
    return await apiClient.postData(
      Constants.baseUrl + Constants.addEvent,
      event.toJson(),
    );
  }

//Edit events
    Future<Response> editEventsApi(Map<String, dynamic> updatedEventData) async {
    return await apiClient.putData(
      Constants.baseUrl + Constants.editEvent,
      updatedEventData,
    );
  }

//Edit status
    Future<Response> editEventStatusApi(Map<String, dynamic> updatedEventStatus) async {
    return await apiClient.putData(
      Constants.baseUrl + Constants.updateEventStatus,
      updatedEventStatus,
    );
  }
}
