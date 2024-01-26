
import 'package:photomanager/utils/export_files.dart';

import '../../../../utils/images.dart';

  class EventCardWidget extends StatelessWidget{
  final EventCard eventCard;
  final EventIdController eventIdController = Get.put(EventIdController());
  // final EventController eventController = Get.put(EventController());//old apiclient
  var attendeesRepo = AttendeesRepo(apiClient: Get.find());
  var eventcontroller = Get.find<EventsController>();

  EventCardWidget({super.key, required this.eventCard});
      @override
      Widget build(BuildContext context) {
        final attendeescontroller = Get.put(AttendeesController(attendeesRepo: attendeesRepo));
        // Get the image string based on the event type
          String eventTypeImage = MyUtils().eventTypeImages[eventCard.eventType] ?? Images.unspecified; 
    
    var eventDetails = EventDetails(
              id: eventCard.id,
            );
        return
           InkWell(
            splashColor: Colors.white,
            borderRadius: BorderRadius.circular(15),
            onTap: ()async{
              //fetch attendees users
               await attendeescontroller.attendeesData( eventCard.id);
              Get.to(
              eventDetails//Go to EventDetails
            );
            },
             child: 
            //  Container(
              // margin: EdgeInsets.only(bottom: Get.width*.02),//10
              // color: Colors.red,
              //        height: Get.width*.8,
              //        child: Stack(
              // alignment: Alignment.bottomCenter,
              // children: [
              //   Container(
              //     color: Colors.blue,
              //     margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              //     height: Get.width*.73,
              //       width: Get.width*.9,
              //       padding: const EdgeInsets.all(8.0),//marked
              //       child: 
              //       Container(
              //         decoration: BoxDecoration(color: MyUtils().getColorForEventType(eventCard.eventType),
              //         borderRadius: BorderRadius.circular(20),
              //         ),
              //         child: 
              //         Padding(
              //           padding: const EdgeInsets.all(18),//18
              //           child: 
              //           Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               mainAxisAlignment: MainAxisAlignment.end,
              //               children: [
                            //   Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //   CustomText(headingStr: eventCard.eventName, weight: TextWeight.semiBold, fontSize: 16, onTap: (){
                            //     Get.to(eventDetails);
                            //     //fetch attendees users
                            //     },),
                            //   sizedHeight(Get.width*.02),//5
                            //   InkWell(
                            //     onTap: () => Get.to(
                            //       eventDetails
                            //     ),
                            //     child: MyUtils().formatTimeUntilEvent(eventCard.eventStartDate, eventCard.eventEndDate, (){
                            //       Get.to(eventDetails);
                            //       //fetch attendees users
                            //       })
                            //     ),
                            //   ],
                            // ),
              //           ]),
              //         ),
              //       ),
              //     ),
                // Positioned(
                //   top: 0,
                //   child: Image.asset(eventTypeImage, height:  Get.width*.5,),
                // )
              // ],
              //        ),
              //      ),



              Container(
                // color: Colors.blue,
                height: Get.width,
                width: Get.width,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  height: Get.width,
                  width: Get.width,
                  // color: Colors.red,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        // color: Colors.amber,
                        margin: EdgeInsets.only(bottom: Get.width*.015),
                        decoration: BoxDecoration(color: MyUtils().getColorForEventType(eventCard.eventType),
                        borderRadius: BorderRadius.circular(15),
                      ),
                        height: Get.width*.73,
                        width: Get.width*.9,
                        child: 
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                CustomText(headingStr: eventCard.eventName, weight: TextWeight.semiBold, fontSize: 16, onTap: (){
                                  Get.to(eventDetails);
                                  },),
                                sizedHeight(Get.width*.02),
                                InkWell(
                                  onTap: () => Get.to(
                                    eventDetails
                                  ),
                                  child: MyUtils().formatTimeUntilEvent(eventCard.eventStartDate, eventCard.eventEndDate, (){
                                    Get.to(eventDetails);
                                    })
                                  ),
                                ],
                              ),
                        ),

                      ),
                      Positioned(
                        top: 0,
                        child: Image.asset(eventTypeImage, height:  Get.width*.5,),
                      ),
                    ],
                  ),
                ),
                

              )
           );
      }
  }