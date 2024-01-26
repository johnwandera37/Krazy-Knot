import 'package:photomanager/utils/export_files.dart';
import 'package:photomanager/utils/images.dart';
final eventWidgets = EventColumn();
final EventIdController eventIdController = Get.put(EventIdController());//make event id availability in the state
final eventcontroller = Get.find<EventsController>();

final attendeescontroller = Get.find<AttendeesController>();
 

// late final AttendeesLink attendeesLink;

class EventDetails extends StatelessWidget{ 
  final String id;
  
   const EventDetails({super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    eventIdController.setEventId(id);//now the id is passed directly to the status update function no need for this, but still useful
    
    return 
    GetBuilder<EventsController>(
      builder: (eventscontroller){
        //get events by id
          EventCard? event = eventscontroller.eventModel?.events.firstWhere((element) => element.id == id,
          // orElse: () => null,
          );
    String eventTypeImage = MyUtils().eventTypeImages[event!.eventType] ?? Images.unspecified;//updates the image of a specific event in event details
    return 
    Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: HexColor('F8DFD4'),
        title: const CustomText(headingStr: 'Event Details', fontSize: 18, weight: TextWeight.bold,),
         toolbarHeight: Get.width*.2,
        leading: IconWidget(icon: Icons.arrow_back, onTap: () {
          eventcontroller.clearForm();
          Get.back();},),
        actions: [
          //Edit events
          IconWidget(icon: Icons.edit, onTap: (){
          
               Get.to(EditEvent(
                      eventId: id,//The event id does not change unlike the other details
                      title: event.eventName, 
                      type: event.eventType, 
                      venue: event.eventVenue, 
                      startDate: event.eventStartDate, 
                      endDate: event.eventEndDate, 
                      description: event.eventDescription,
                      )
                      );      
          }),
        //Cancel events     
        if(event.eventStatus.toLowerCase() != 'cancelled')
         IconWidget(icon:  Icons.delete_forever, onTap: (){
          eventCancel(context: context, status: event.eventStatus);
        })
        ],
      ),
      backgroundColor: HexColor('FFFBF5'),
      body: 
      Stack(
        children: [
          ClipPath(
            clipper: CustomSelfClipper2(),
            child: Container(
              height: Get.width*.7,
              decoration: BoxDecoration(
                color: HexColor("F8DFD4")),
            ),
          ),
               Positioned(
              left: 5,
              right: 5,
              child: Image.asset(eventTypeImage, height:  Get.width*.5,),
            ),
      
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sizedHeight(Get.width*.65),
             Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
             child: 
             eventWidgets.eventColumn(title: event.eventName, type: event.eventType, start: event.eventStartDate, end: event.eventEndDate, location: event.eventVenue, description: event.eventDescription, status: event.eventStatus, id: id, context: context, )
            
             ),
             sizedHeight(Get.width*.1),
             if(event.eventStatus.toLowerCase() == 'ready' && event.eventStartDate.isAfter(DateTime.now()))
             CustomButton(buttonStr: 'Invite Members', btncolor: HexColor('FFAD84'), onTap: () async{
                await attendeescontroller.getTheLink(); // Wait for getTheLink to complete, create a progress widget as it waits

                final AttendeesLink? attendeesLink = attendeescontroller.attendeesLinkModel?.link.isNotEmpty == true
                ? attendeescontroller.attendeesLinkModel!.link.first
                : null;

                if (attendeesLink != null) {
                    debugPrint('😎😎😎Check my link here ${attendeesLink.eventLink}');
                    String shareContent = attendeesLink.eventLink;
                    Share.share(shareContent);
                  } else {
                    debugPrint('😞 Link not available');
                  }
             })
             else 
              MyUtils().helperTextFunction(status: event.eventStatus, startDate: event.eventStartDate, endDate: event.eventEndDate),
              sizedHeight(Get.width*.1)
            ],
          ),
        ),
        ],
      )
    );

    },
    );
  }
}