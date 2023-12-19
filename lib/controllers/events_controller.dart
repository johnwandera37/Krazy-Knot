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

  RxBool loadingData = false.obs;
  RxBool loadingTickets = false.obs;

  Future<void> eventData() async{
    try{
    var userInfo = Get.find<ProfileController>().userInfo;

      Response response = await eventsRepo.getEventsApi(eventOwner: userInfo!.id);
      if(response.statusCode == 200){
        _eventModel = EventModel.fromJson(response.body);
        debugPrint('🙋‍♂️🙋‍♂️🙋‍♂️🙋‍♂️$_eventModel');
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