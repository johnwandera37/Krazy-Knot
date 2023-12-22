import 'package:photomanager/controllers/profile_controller.dart';
import 'package:photomanager/data/repo/events_repo.dart';
import '../data/model/response/events_model.dart';
import '../utils/export_files.dart';

class EventsController extends GetxController{
  final EventsRepo eventsRepo;

  EventsController({
    required this.eventsRepo,
  });

  EventModel? _eventModel;
  EventModel? get eventModel => _eventModel;

  RxBool loadingEvents = false.obs;

  Future<void> eventData() async{
    loadingEvents(true);
    try{
    var userInfo = Get.find<ProfileController>().userInfo;
      Response response = await eventsRepo.getEventsApi(eventOwner: userInfo!.id);
      if(response.statusCode == 200){
        loadingEvents(false);
           debugPrint('🚌🚌🚌🚌 The getEvents Api has been excecuted and the folowing is the data: ');//${response.body}
        _eventModel = EventModel.fromJson(response.body);
      }else{
        ApiChecker.checkApi(response);
      }
       update();
    }catch (e){
      debugPrint("Error: $e");
    }finally{
      update(); 
    }
  }

}