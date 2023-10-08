import '../../utils/export_files.dart';
import '../../utils/images.dart';

class CancelledEvents extends StatefulWidget{
  CancelledEvents({super.key});

  @override
  State<CancelledEvents> createState() => _CancelledEventsState();
}

class _CancelledEventsState extends State<CancelledEvents> {
 final EventController eventController = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {

    final List<Event> cancelledEvents = eventController.events
    .where((event) => event.eventStatus == "Cancelled")
    .toList();

       return Scaffold(
      body: Container(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          sizedHeight(30),
          Center(child: CustomText(headingStr: 'Cancelled Events', fontSize: 16, weight: TextWeight.bold,)),
          sizedHeight(20),

          Wrap(
          spacing: 24.0,
          runSpacing: 24.0,
          children: cancelledEvents.isNotEmpty
    ? cancelledEvents.
          map((event) {
            return  Container(
              // width: Get.width * 0.195, // Set the desired width for each eventTile
              child: eventTile(
                eventType: event.eventType,
                eventTitle: event.eventName,
                eventDate:'${formatDateTime(event.eventStartDate!)} - ${formatDateTime(event.eventEndDate!)}',
                eventDescription: event.eventDescription,
                eventStrId: event.id.toString(), 
                eventStrStatus: event.eventStatus,
                evenStrVenue: event.eventVenue, 
                eventEndDateStr: event.eventEndDate, 
                eventStartDateStr: event.eventStartDate, 
                eventStrOwner: event.eventOwner, context: context,//for confirmation the dialog
                onTap: (){
                  if(event.eventStatus == "Ready"){
                     popUpCard(
                    context: context,  
                    status: event.eventStatus, 
                    );
                  }else{
                    //display snack bar
                     ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Event venue is not ready.'),
                    ),
                  ); 
                  }
                 
                }
              ),
            );
          }).toList():
        [
        Center(child:Container(
                height: 190,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    CustomText(headingStr: "Your cancelled events will appear here", fontSize: 15),
                    sizedHeight(20),
                    Image.asset(
                      Images.featured,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                      )
                  ],)
                 
                  ))
      ]
        ),
        
        ],
       ),
      ),
    );
  }
}
