import 'package:photomanager/utils/export_files.dart';
import 'package:photomanager/utils/images.dart';
final eventWidgets = EventColumn();
final EventIdController eventIdController = Get.put(EventIdController());//make event id availability in the state
final eventcontroller = Get.find<EventsController>();

var eventsRepo = AttendeesRepo(apiClient: Get.find());
final attendeescontroller = Get.put(AttendeesController(attendeesRepo: eventsRepo));

// late final AttendeesLink attendeesLink;

class EventDetails extends StatelessWidget{
  final String id;
  final String status;
  final String name;
  final String type;
  final String location;
  final DateTime startDate;
  final DateTime endDate;
  final String eventDescription;


   const EventDetails({super.key,
    required this.id,
    required this.status,
    required this.name,
    required this.type,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.eventDescription,
  });

  @override
  Widget build(BuildContext context) {
    eventIdController.setEventId(id);
       String eventTypeImage = MyUtils().eventTypeImages[type] ?? Images.unspecified;
    return 
    Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: HexColor('F8DFD4'),
        title: CustomText(headingStr: 'Event Details', fontSize: 18, weight: TextWeight.bold,),
        leading: IconWidget(icon: Icons.arrow_back, onTap: () {
          eventcontroller.clearForm();
          Get.back();},),
        actions: [
          //Edit events
          IconWidget(icon: Icons.edit, onTap: (){
               Get.to(EditEvent(
                      eventId: id,
                      title: name, 
                      type: type, 
                      venue: location, 
                      startDate: startDate, 
                      endDate: endDate, 
                      description: eventDescription,
                      ));
          }),
        //Cancel events     
        if(status.toLowerCase() != 'cancelled')
         IconWidget(icon:  Icons.delete_forever, onTap: (){
          eventCancel(context: context, status: status);
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
             eventWidgets.eventColumn(title: name, type: type, start: startDate, end: endDate, location: location, description: eventDescription, status: status, id: id, context: context)
            
             ),
             sizedHeight(Get.width*.1),
             if(status.toLowerCase() == 'ready' && endDate.isAfter(DateTime.now()))
             CustomButton(buttonStr: 'Invite Members', btncolor: HexColor('FFAD84'), onTap: () async{
                await attendeescontroller.getTheLink(); // Wait for getTheLink to complete

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
              MyUtils().helperTextFunction(status: status, startDate: startDate, endDate: endDate),
              sizedHeight(Get.width*.1)
            ],
          ),
        ),
        ],
      )
    );
  }
}