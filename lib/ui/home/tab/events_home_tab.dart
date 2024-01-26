import 'package:photomanager/controllers/profile_controller.dart';
import 'package:photomanager/data/repo/events_repo.dart';
import 'package:photomanager/utils/export_files.dart';
import 'package:photomanager/utils/images.dart';
 
class HomeTabScreen extends StatefulWidget{
  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
    var profile = Get.find<ProfileController>();
    var eventsRepo = EventsRepo(apiClient: Get.find());

  @override
  Widget build(BuildContext context) {
    var eventcontroller = Get.put(EventsController(eventsRepo: eventsRepo));
    eventcontroller.eventData();
    eventcontroller.updateStatusBasedOnEndDate();

  Widget buildEventList(){
  if(eventcontroller.eventModel == null || eventcontroller.eventModel!.events.isEmpty){
    return const Center(
        child: CustomText(
          headingStr: "Your events\nwill be collected here",
          weight: TextWeight.semiBold,
          fontSize: 17,
        ),
      );
  }else{
        debugPrint('🎉🎉🎉Check number of events   +++++++ ${eventcontroller.eventModel!.events.length}');
        // Sort tickets based on the date in descending order (latest date first)
        eventcontroller.eventModel!.events.sort((a, b) => b.eventStartDate.compareTo(a.eventStartDate));
      return
       RefreshIndicator(
         onRefresh: () async {
        setState(() {
          eventcontroller.eventData();
           eventcontroller.eventModel!.events;
        });
      },
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:  eventcontroller.eventModel!.events.length,
          itemBuilder: (BuildContext context, int index) {
            EventCard event =  eventcontroller.eventModel!.events[index];
            return EventCardWidget(eventCard: event,);
          },
        ),
      );
  }
}

    return 
    Scaffold(
      backgroundColor: HexColor('FFFBF5'),
      body: 
      Stack(
        children: [
          ClipPath(
            clipper: CustomSelfClipper2(),
            child: Container(
              height: Get.height*.37,//Get.width*.7
              decoration: BoxDecoration(
                color: HexColor("F8DFD4")),
            ),
          ),
             Positioned(
              right: 15,
              top: Get.width*.07,
              child: Image.asset(Images.events,height:  Get.width*.5,),//210
            ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Padding(padding: EdgeInsets.symmetric(horizontal: 20),
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               sizedHeight(Get.width*.05),
            const CustomText(headingStr: Constants.howdy, fontSize: 30,),
            sizedHeight(10),
            CustomText(headingStr: MyUtils.capitalizeFirstLetter(profile.userInfo!.firstName), fontSize: 30, weight: TextWeight.bold,),
            sizedHeight(Get.width*.15),
            const CustomText(headingStr: Constants.createEvent, fontSize: 15,),
             sizedHeight(Get.width*.04),
            CustomButton(
              buttonStr: Constants.createstr, btncolor: HexColor('FFAD84'), onTap: (){
              Get.to(const CreateEvent());
            }),
            sizedHeight(Get.width*.15),
             Row(
               children: [
                 const CustomText(headingStr: Constants.yourEvent, fontSize: 15,),
                Image.asset(Images.charmbird,height: 30,),
               ],
             ),
           ]),
           ),
              Obx(() => 
                Expanded(
                child: 
              eventcontroller.loadingEvents.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: HexColor('87C4FF')
                  ),
                )
              : 
              buildEventList(),
            )
            ),
          ],
        ),
        ],
      )
    );
  }
}