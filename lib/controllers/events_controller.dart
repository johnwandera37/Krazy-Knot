import 'package:photomanager/controllers/profile_controller.dart';
import 'package:photomanager/data/repo/events_repo.dart';
import '../utils/export_files.dart';

class EventsController extends GetxController{
  final EventsRepo eventsRepo;
  var userInfo = Get.find<ProfileController>().userInfo;
  var mapPickerController =  Get.put(MapPickerController());//for location value
  var dateTimeController = Get.put(DateTimeController());//for date values
  final EventIdController eventIdController = Get.put(EventIdController());//event id in the state


  // Capture values events inputs
  var title = TextEditingController();
  var description = TextEditingController();
  var selectType = TextEditingController();

  void clearForm() {
    title.clear();
    description.clear();
    selectType.clear();
    mapPickerController.clearAddress();
    dateTimeController.clearDateTime();
  }


  EventsController({
    required this.eventsRepo,
  });

  EventModel? _eventModel;
  EventModel? get eventModel => _eventModel;

  RxBool loadingEvents = false.obs;
  RxBool loadingEditedEvent = false.obs;
  RxBool loadingEditedStatus = false.obs;


//fetch events
  Future<void> eventData() async{
    loadingEvents(true);
    try{
      Response response = await eventsRepo.getEventsApi(eventOwner: userInfo!.id);
      if(response.statusCode == 200){
        loadingEvents(false);
           debugPrint('🚌🚌🚌🚌 The getEvents Api has been excecuted and the following is the data: ');//${response.body}
        _eventModel = EventModel.fromJson(response.body);
      }else{
        ApiChecker.checkApi(response);
          MyStyles().showSnackBar(
          messageText: 'Something went wrong when fetching events data.');
      }
       update();
    }catch (e){
      debugPrint("Get Events 🚌🚌🚌🚌Error: $e");
       MyStyles().showSnackBar(messageText: 'Error: $e');
    }finally{
      loadingEvents(false);
      update(); 
    }
  }

//create events
 Future<void> postEventData(BuildContext context) async{
  final DateTime startTime = dateTimeController.selectedDateTime.value;
  final DateTime endTime = dateTimeController.selectedEndDateTime.value;
    try{
      final event = EventCard(
      id: "",
      eventOwner:  userInfo!.id,
      eventName: title.text,
      eventType: selectType.text,
      eventVenue: mapPickerController.address.value,
      eventDescription: description.text,
      eventStartDate: startTime,
      eventEndDate: endTime,
      eventStatus: 'Pending',//by default
    );
      Response response =  await eventsRepo.postEventsApi(event);
        if(response.statusCode == 200){
          loadingEditedEvent(false);
          debugPrint('🚀🚀🚀 The postEventsApi has been executed successfully.');
            MyStyles().showSnackBarGreen(messageText: "Event has been created successful");
           clearForm();
           Navigator.pop(context);
        }else{
          ApiChecker.checkApi(response);
          MyStyles().showSnackBar(messageText: "Failed to create this event");
        }
       update();
    }catch (e){
      debugPrint("Error: $e");
      MyStyles().showSnackBar(messageText: "Error: $e");
    }finally{
      update();
    }
  }

  //Edit events
  Future<void> editEventData(BuildContext context) async{
  loadingEditedEvent(true);
  final DateTime startTime = dateTimeController.selectedDateTime.value;
  final DateTime endTime = dateTimeController.selectedEndDateTime.value;
  String eventId = eventIdController.eventId.value;
  
    try{
      final edit = EditEventCard(
      eventId: eventId,
      eventOwner:  userInfo!.id,
      eventName: title.text,
      eventType: selectType.text,
      eventVenue: mapPickerController.address.value,
      eventDescription: description.text,
      eventStartDate: startTime,
      eventEndDate: endTime,
      eventStatus: 'Pending',//by default
    );
    
     final requestBody = {
        "eventId": edit.eventId,
        "updatedEventData": edit.toMap(),
      };

      Response response =  await eventsRepo.editEventsApi(requestBody);
        if(response.statusCode == 200){
           loadingEditedEvent(false);
           debugPrint('😇😇😇 The editEventsApi has been executed successfully.');
            await MyStyles().showSnackBarGreen(messageText: "Event has been edited successful");
            clearForm();
            Navigator.pop(context);
        }else{
          ApiChecker.checkApi(response);
          MyStyles().showSnackBar(messageText: "Failed to dit this event");
        }
       update();
    }catch (e){
      debugPrint("Error: $e");
      MyStyles().showSnackBar(messageText: "Error: $e");
    }finally{
      loadingEditedEvent(false);
      update();
    }
  }


  //Edit event's status
  Future<void> editEventStatus({required String eventStatus}) async{
  String eventId = eventIdController.eventId.value;
    try{
      final edit = EditEventStatus(
      eventId: eventId,
      eventStatus: eventStatus
    );
    
     final requestBody = {
        "eventId": edit.eventId,
        "updatedEventStatus": edit.toMap(),
      };
      Response response =  await eventsRepo. editEventStatusApi(requestBody);
        if(response.statusCode == 200){
           debugPrint('😐😐😐 The editStatusApi has been executed successfully.');
            await MyStyles().showSnackBarGreen(messageText: "Status updated to $eventStatus");
            await eventData();
        }else{
          ApiChecker.checkApi(response);
          MyStyles().showSnackBar(messageText: "Failed to edit this event's status");
        }
       update();
    }catch (e){
      debugPrint("Error: $e");
      MyStyles().showSnackBar(messageText: "Error: $e");
    }finally{
      update(); 
    }
  }

}