
import 'package:photomanager/utils/export_files.dart';

import '../../../../utils/images.dart';

  class EventCardWidget extends StatelessWidget{
  final EventCard eventCard;

  const EventCardWidget({super.key, required this.eventCard});
      @override
      Widget build(BuildContext context) {
        // Get the image string based on the event type
          String eventTypeImage = MyUtils().eventTypeImages[eventCard.eventType] ?? Images.unspecified;
    
    var eventDetails = EventDetails(
              id: eventCard.id,
              status: eventCard.eventStatus,
              name: eventCard.eventName,
              type: eventCard.eventType,
              location: eventCard.eventVenue,
              startDate: eventCard.eventStartDate,
              endDate: eventCard.eventEndDate,
              eventDescription: eventCard.eventDescription,

            );
        return
           InkWell(
            splashColor: Colors.white,
            borderRadius: BorderRadius.circular(15),
            onTap: () => Get.to(
              eventDetails//Go to EventDetails
              //fetch attendees users
              
            ),
             child: Container(
              margin: EdgeInsets.only(bottom: Get.width*.02),//10
              // color: Colors.red,
                     height: Get.width*.8,//Get.width*.8
                     child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  height: Get.width*.73,
                    width: Get.width*.9,
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(color: MyUtils().getColorForEventType(eventCard.eventType),
                      borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),//18
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              CustomText(headingStr: eventCard.eventName, weight: TextWeight.semiBold, fontSize: 16, onTap: (){
                                Get.to(eventDetails);
                                //fetch attendees users
                                },),
                              sizedHeight(Get.width*.02),//5
                              InkWell(
                                onTap: () => Get.to(
                                  eventDetails
                                ),
                                child: MyUtils().formatTimeUntilEvent(eventCard.eventStartDate, eventCard.eventEndDate, (){
                                  Get.to(eventDetails);
                                  //fetch attendees users
                                  })
                                )
                              ],
                            ),
                        ]),
                      ),
                    ),
                  ),
                Positioned(
                  top: 0,
                  child: Image.asset(eventTypeImage, height:  Get.width*.5,),
                )
              ],
                     ),
                   ),
           );
      }
  }