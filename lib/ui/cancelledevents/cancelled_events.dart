
//THIS THE OLD UI ITS HAS NOT USED IN THE UPDATED UI SINCE CANCELLED OPTION FROM THE DRAWER MENU HAS BEEN REMOVED

import '../../utils/export_files.dart';
import '../../utils/images.dart';
import 'package:photomanager/controllers/profile_controller.dart';

class CancelledEvents extends StatefulWidget {
  const CancelledEvents({super.key});

  @override
  State<CancelledEvents> createState() => _CancelledEventsState();
}

class _CancelledEventsState extends State<CancelledEvents> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = Get.width;
    var screenHeight = Get.height;
    final EventController eventController = Get.put(EventController());

    final List<Event> cancelledEvents = eventController.cancelledEvents;//only cancelled events
    

    return 
    GetX<EventController>(builder: (eventController) => 
    Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Center(
            child: Text(
              "Cancelled Events",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            initUserId() async {
              var controller = Get.find<ProfileController>();
              var profileData = await controller.profileData();
              debugPrint('NEW USER IDDDD :::::::  ${controller.userInfo!.id}');
              var user_id = controller.userInfo!.id;
              return user_id;
            }

            var user = await initUserId();
            eventController.fetchEvents(user);

            setState(() {
              eventController.cancelledEvents;
            });
          },
          child: ListView(children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cancelledEvents.isNotEmpty
                      ? Wrap(
                          spacing: 24.0,
                          runSpacing: 24.0,
                          children: cancelledEvents.map((event) {
                            return Container(
                              width: screenWidth,
                              height: screenHeight * .26,
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: eventTile(
                                eventType: event.eventType,
                                eventTitle: event.eventName,
                                eventDate:
                                    '${formatDateTime(event.eventStartDate!)} - ${formatDateTime(event.eventEndDate!)}',
                                eventDescription: event.eventDescription,
                                eventStrId: event.id.toString(),
                                eventStrStatus: event.eventStatus,
                                evenStrVenue: event.eventVenue,
                                eventEndDateStr: event.eventEndDate,
                                eventStartDateStr: event.eventStartDate,
                                eventStrOwner: event.eventOwner,
                                context: context, // for confirmation the dialog
                                onTap: () {
                                  if (event.eventStatus == "Ready") {
                                    popUpCard(
                                      context: context,
                                      status: event.eventStatus,
                                    );
                                  } else {
                                    // display snack bar
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Event venue is not ready.'),
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          }).toList(),
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Your cancelled events will appear here",
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                              sizedHeight(20),
                              Image.asset(
                                Images.featured,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ]),
        ))
    );
  }
}
