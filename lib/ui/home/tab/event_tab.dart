import 'package:photomanager/ui/base/widgets/custom_image.dart';
import 'package:photomanager/utils/images.dart';

import '../../../utils/export_files.dart';
import 'package:intl/intl.dart';


class EventTab extends StatelessWidget {

  
  EventTab({super.key});
    final EventController eventController = Get.put(EventController());
    final now = DateTime.now();

  @override
  Widget build(BuildContext context) {

//using a function to filter events
List<Event> filterFeaturedEvents(List<Event> allEvents) {
  final now = DateTime.now();
  final startOfWeek = DateTime(now.year, now.month, now.day);
  final endOfWeek = startOfWeek.add(Duration(days: 7));
  // Filter the events that fall within the upcoming week
  final featuredEvents = allEvents.where((event) {
    final eventDate = DateTime.parse(event.eventStartDate); // Parse the event date
    return eventDate.isAfter(startOfWeek) && eventDate.isBefore(endOfWeek);
  }).toList();
  return featuredEvents;
}

    return 
    Obx(() =>
    Scaffold(
      backgroundColor: HexColor("F7F7F7"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: 
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
            //title my events
            const Center(child: CustomText(headingStr: "My Events", fontSize: 16, weight: TextWeight.bold,)),
            sizedHeight(10),

            //featured events section
            const CustomText(headingStr: 'Featured Events', fontSize: 16, weight: TextWeight.semiBold,),
            sizedHeight(20),
            filterFeaturedEvents(eventController.events).isEmpty
              ?  Center(child:Container(
                width: 100,
                height: 190,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    CustomText(headingStr: "Your featured events will appear here", fontSize: 15),
                    sizedHeight(20),
                    Image.asset(
                      Images.featured,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                      )
                  ],)
                 
                  ))
              :Container(
                height: 200,
               child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filterFeaturedEvents(eventController.events).length,
                itemBuilder: (BuildContext context, int index) {
                  final event = filterFeaturedEvents(eventController.events)[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: eventTile(eventType: event.eventType,
                    eventTitle: event.eventName,
                    eventDate: '${formatDateTime(event.eventStartDate!)} - ${formatDateTime(event.eventEndDate!)}',
                    eventId: event.id.toString(), 
                    eventDescription: event.eventDescription),
                    
                  );
                },
                ),
             ),
            sizedHeight(30),
            //events section
            Row(children: const [
               CustomText(headingStr: 'Events', fontSize: 16, weight: TextWeight.semiBold,),
              ],),
            sizedHeight(20),

            //all events come here
           Container(
  child: eventController.events.isEmpty
      ? Center(
        child: Container(
                  height: 200,
                    child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(headingStr: "You don't have any events created", fontSize: 15),
                        sizedHeight(20),
                         Image.asset(Images.empty,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                         )
                      ],
                    )
                    ),
      )
      : Wrap(
          spacing: 24.0,
          runSpacing: 24.0,
          children: eventController.events.map((event) {
            return  Container(
              // width: Get.width * 0.195, // Set the desired width for each eventTile
              child: eventTile(
                eventType: event.eventType,
                eventTitle: event.eventName,
                eventDate:'${formatDateTime(event.eventStartDate!)} - ${formatDateTime(event.eventEndDate!)}',
                eventId: event.id.toString(), 
                eventDescription: event.eventDescription,//get each event id
              ),
            );
          }).toList(),
        ),
)

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Get.to(CreateEvent());
        },
        child:const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    )
    );
  }
}

//event tile
Widget eventTile({
    required eventType,
    required eventTitle,
    required eventDate,
    VoidCallback? onTap,
    // required VoidCallback onEdit, // Add the onEdit callback
    required String eventId,
    required String eventDescription
  
   }){
    //map that maps event types to image paths
    final Map<String, String> eventTypeToImage = {
    'Technology': Images.technology,
    'Education': Images.education,
    'Business': Images.business,
    'Food': Images.food,
    'Wedding': Images.wedding,
    'Sports': Images.sports,
  };
  final String imagePath = eventTypeToImage[eventType] ?? Images.event;//string that determine path based on event type
   return
    InkWell(
    onTap: onTap,
    child:
   Container(
    width: Get.width * .3,//.195,
    height: Get.width * .15,//1
    decoration: inputDecoration(),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
      child: 
      Column(
         crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(children: [
          Row(children: [
          CustomImage(image: imagePath, imageWidth: 24, imageHeight: 24),
          sizedWidth(8),
          CustomText(headingStr: eventType, fontSize: 16, weight: TextWeight.semiBold,)
          ],),
          const Spacer(),
          Container(child: PopUpMenu(eventId: eventId.toString()))//onEdit: () => onEdit(),
        ],),
        //event title
        Container(
          height: 43,
          child: CustomText(headingStr: eventTitle, fontSize: 15,)),

          //event descsiption
          Container(
             height: 50,
            child:  CustomText(headingStr: eventDescription, fontSize: 15,)
          ,),
        //date
        Align(
          heightFactor: 2,
           alignment: Alignment.bottomLeft, 
          child: CustomText(headingStr: eventDate, fontColor: HexColor("151515"), fontSize: 11,))
      ]),
      ),

)
    );
   }

//PopUPMenu
Widget PopUpMenu({
  // required VoidCallback onEdit, // Add the onEdit callback
  required String eventId, // Add eventId parameter
})=> PopupMenuButton<String>(
      iconSize: 17,
      splashRadius: 16,  
      onSelected: (String choice) {
        // Handle the choice selected from the menu
        if (choice == 'Edit') {
          // onEdit(eventId); 
          Get.to(EditEvent(eventId: eventId));
          
        } else if (choice == 'Update Status') {
          
        }
        else if (choice == 'Cancel Event') {
          
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: 'Edit',
            child: Text('Edit'),
          ),
          const PopupMenuItem<String>(
            value: 'Update Status',
            child: Text('Update Status'),
          ),
            const PopupMenuItem<String>(
            value: 'Cancel',
            child: Text('Cancel'),
          ),
        ];
      },
    );

String formatDateTime(String date) {
  try {
    final parsedDate = DateTime.parse(date);
    final formattedDate = DateFormat('MMM dd yyyy HH:mm').format(parsedDate);
    return formattedDate;
  } catch (e) {
    //unexpected date format
    return 'Invalid Date ${date}';
  }
}