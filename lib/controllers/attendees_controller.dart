import 'dart:convert';

import 'package:photomanager/controllers/profile_controller.dart';
import 'package:photomanager/data/repo/events_repo.dart';
import '../utils/export_files.dart';

class AttendeesController extends GetxController{
  final AttendeesRepo attendeesRepo;
  var userInfo = Get.find<ProfileController>().userInfo;

  final EventIdController eventIdController = Get.put(EventIdController());//event id

  AttendeesController({
    required this.attendeesRepo,
  });

  AttendeesModel? _attendeesModel;
  AttendeesModel? get attendeesModel => _attendeesModel;

  RxBool loadingAttendeesData = false.obs;


//fetch attendees
  Future<void> attendeesData(eventId) async{
    loadingAttendeesData(true);
    // String eventId = eventIdController.eventId.value;
    
    try{
      Response response = await attendeesRepo.getAttendeesApi(eventId: eventId);
      if(response.statusCode == 200){
        loadingAttendeesData(false);
           debugPrint('😃😃😃 The getAttendees Api has been excecuted and the following is the data: ${response.body}');//${response.body}
        _attendeesModel = AttendeesModel.fromJson(response.body);
      }else{
        ApiChecker.checkApi(response);
          MyStyles().showSnackBar(
          messageText: 'Something went wrong when fetching attendees data.');
      }
       update();
    }catch (e){
      debugPrint("Get Attendees Error: $e");
       MyStyles().showSnackBar(messageText: 'Error: $e');
    }finally{
      loadingAttendeesData(false);
      update();
    }
  }

//create attendees NOT USED AT THE MOMENT
 Future<void> postAttendeesData(eventId) async{
   String eventId = eventIdController.eventId.value;
    // loadingEvents(true);
    try{
      final atendee = AttendeesCard(
      eventId:  eventId, 
      attendeeName: '', 
      attendeePhone: '',
    );
      Response response =  await attendeesRepo.postAttendeesApi(atendee);
        if(response.statusCode == 200){debugPrint('🔎🔎🔎 The postAttendeesApi has been executed successfully.');
            MyStyles().showSnackBarGreen(messageText: "Event has been created successful");
          //  clearForm();
          //  Get.back();
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


 AttendeesLinkModel? _attendeesLinkModel;
  AttendeesLinkModel? get attendeesLinkModel => _attendeesLinkModel;

    Future getTheLink() async{
    String eventId = eventIdController.eventId.value;
    try{
      Response response = await attendeesRepo.getEventLink(eventId);
      if (response.statusCode == 200) {
      debugPrint('🔗🔗🔗🔗 The getEventLink Api has been executed, and the following is the body: ${response.body}');
      _attendeesLinkModel = AttendeesLinkModel.fromJson(response.body);
      }else{
        ApiChecker.checkApi(response);
          MyStyles().showSnackBar(
          messageText: 'Something went wrong when getting the invitation link');
          update();
      }
    
    }catch (e){
      debugPrint("Get Link 🔗🔗Error: $e");
       MyStyles().showSnackBar(messageText: 'Error: $e');
    }finally{
      update();
    }
  }

}