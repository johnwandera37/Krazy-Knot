import 'package:photomanager/controllers/profile_controller.dart';
import 'package:photomanager/ui/base/widgets/custom_image.dart';
import 'package:photomanager/utils/images.dart';

import '../../../utils/export_files.dart';
import 'package:intl/intl.dart';

class EventTab extends StatelessWidget {
  EventTab({super.key});
  
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var screenHeight = Get.height;
    var screenWidth = Get.width;
    final EventController eventController = Get.put(EventController());
    var profileRepo =Get.put(ProfileRepo(apiClient: Get.find()));
    //using a function to filter events
    // var profileController = Get.put(ProfileController(profileRepo: profileRepo));
    // debugPrint('USER IDDE ::::::::::::: ${profileController.userInfo!.id}');
    List<Event> filterFeaturedEvents(List<Event> allEvents) {
      final now = DateTime.now();
      final startOfWeek = DateTime(now.year, now.month, now.day);
      final endOfWeek = startOfWeek.add(const Duration(days: 7));
      // Filter the events that fall within the upcoming week
      final featuredEvents = allEvents.where((event) {
        final eventDate =
            DateTime.parse(event.eventStartDate); // Parse the event date
        return eventDate.isAfter(startOfWeek) &&
            eventDate.isBefore(endOfWeek) &&
            event.eventStatus.toLowerCase() != 'cancelled';
      }).toList();
      return featuredEvents;
    }

    List<Event> filterRemainingEvents(List<Event> allEvents) {
      final now = DateTime.now();
      final startOfWeek = DateTime(now.year, now.month, now.day);
      final endOfWeek = startOfWeek.add(const Duration(days: 7));
      final remainingEvents = allEvents.where((event) {
        final eventDate =
            DateTime.parse(event.eventStartDate); // Parse the event date
        return eventDate.isAfter(endOfWeek) &&
            event.eventStatus.toLowerCase() != 'cancelled';
      }).toList();
      return remainingEvents;
    }

    return Obx(() => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Center(
            child: Text(
              "My Events",
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
              eventController.fetchEvents('65081b6f44dbbead5990e40a');
              // setState(() {
              //   eventController.events;
              // });
            },
            child: ListView(
              padding: const EdgeInsets.only(bottom: 20),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 20),
                    //   child: Center(
                    //     child: Text(
                    //       "My Events",
                    //       style: TextStyle(
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.black,
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // Upcoming Events Section
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Upcoming Events',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    sizedHeight(20),

                    // Upcoming Events Container
                    filterFeaturedEvents(eventController.events).isEmpty
                        ? Center(
                            child: SizedBox(
                              width: screenWidth * .8,
                              height: screenHeight * 0.25,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Your upcoming events will appear here",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
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
                          )
                        : SizedBox(
                            height: screenHeight * 0.25,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  filterFeaturedEvents(eventController.events)
                                      .length,
                              itemBuilder: (BuildContext context, int index) {
                                final event = filterFeaturedEvents(
                                    eventController.events)[index];
                                return Container(
                                  width: screenWidth * .9,
                                  height: screenHeight * .22,
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
                                    context: context,
                                    onTap: () {
                                      popUpCard(
                                        context: context,
                                        eventId: event.id,
                                        title: event.eventName,
                                        venue: event.eventVenue,
                                        type: event.eventType,
                                        status: event.eventStatus,
                                        description: event.eventDescription,
                                        startDate: event.eventStartDate,
                                        endDate: event.eventEndDate,
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                    sizedHeight(30),

                    // Other Events Section
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Other Events',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    sizedHeight(20),

                    // Other Events Container
                    Container(
                      child: filterRemainingEvents(eventController.events)
                              .isEmpty
                          ? Center(
                              child: SizedBox(
                                height: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "You don't have any events created",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                    sizedHeight(20),
                                    Image.asset(
                                      Images.empty,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fill,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              children: filterRemainingEvents(
                                      eventController.events)
                                  .where((event) =>
                                      event.eventStatus.toLowerCase() !=
                                      "cancelled")
                                  .map((event) => Center(
                                        child: SizedBox(
                                          width: screenWidth * .9,
                                          height: screenHeight * .24,
                                          child: eventTile(
                                            eventType: event.eventType,
                                            eventTitle: event.eventName,
                                            eventDate:
                                                '${formatDateTime(event.eventStartDate!)} - ${formatDateTime(event.eventEndDate!)}',
                                            eventDescription:
                                                event.eventDescription,
                                            eventStrId: event.id.toString(),
                                            eventStrStatus: event.eventStatus,
                                            evenStrVenue: event.eventVenue,
                                            eventEndDateStr: event.eventEndDate,
                                            eventStartDateStr:
                                                event.eventStartDate,
                                            eventStrOwner: event.eventOwner,
                                            context: context,
                                            onTap: () {
                                              if (event.eventStatus
                                                      .toLowerCase() ==
                                                  "ready") {
                                                popUpCard(
                                                  context: context,
                                                  eventId: event.id,
                                                  title: event.eventName,
                                                  venue: event.eventVenue,
                                                  type: event.eventType,
                                                  status: event.eventStatus,
                                                  description:
                                                      event.eventDescription,
                                                  startDate:
                                                      event.eventStartDate,
                                                  endDate: event.eventEndDate,
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Event venue is not ready.'),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {
              Get.to(const CreateEvent());
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ));
  }
}

//event tile
Widget eventTile({
  required BuildContext context,
  required eventType,
  required eventTitle,
  required eventDate,
  required String eventDescription,
  VoidCallback? onTap,
  //for edit endpoint
  required String eventStrId,
  required String eventStrStatus,
  required String eventStrOwner,
  required String evenStrVenue,
  required String eventStartDateStr,
  required String eventEndDateStr,
}) {
  //map that maps event types to image paths
  final Map<String, String> eventTypeToImage = {
    'Technology': Images.technology,
    'Education': Images.education,
    'Business': Images.business,
    'Food': Images.food,
    'Wedding': Images.wedding,
    'Sports': Images.sports,
  };
  final String imagePath = eventTypeToImage[eventType] ??
      Images.event; //string that determine path based on event type
  return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width * .3, //.195,
        height: Get.width * .15, //1
        decoration: inputDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Row(
                  children: [
                    CustomImage(
                        image: imagePath, imageWidth: 35, imageHeight: 35),
                    sizedWidth(8),
                    CustomText(
                      headingStr: eventType,
                      fontSize: 16,
                      weight: TextWeight.semiBold,
                    )
                  ],
                ),
                const Spacer(),
                Container(
                    child: PopUpMenu(
                  eventId: eventStrId.toString(),
                  status: eventStrStatus,
                  venue: evenStrVenue,
                  type: eventType,
                  owner: eventStrOwner,
                  title: eventTitle,
                  description: eventDescription,
                  startDate: eventStartDateStr,
                  endDate: eventEndDateStr,
                  context: context,
                ))
              ],
            ),
            //event title
            SizedBox(
                height: 43,
                child: CustomText(
                  headingStr: eventTitle,
                  fontSize: 15,
                  weight: TextWeight.bold,
                )),

            //event descsiption
            SizedBox(
              height: 50,
              child: CustomText(
                headingStr: eventDescription,
                fontSize: 15,
              ),
            ),
            //date
            Align(
                heightFactor: 1,
                child: Row(
                  children: [
                    CustomText(
                      headingStr: eventDate,
                      fontColor: HexColor("151515"),
                      fontSize: 11,
                    ),
                    const Spacer(),
                    CustomText(
                      headingStr: eventStrStatus,
                      fontColor: HexColor("151515"),
                      fontSize: 11,
                    )
                  ],
                ))
          ]),
        ),
      ));
}

//PopUPMenu
Widget PopUpMenu({
  required String eventId,
  required String status,
  required String title,
  required String owner,
  required String type,
  required String venue,
  required String description,
  required String startDate,
  required String endDate,
  required BuildContext context,
}) =>
    PopupMenuButton<String>(
      iconSize: 17,
      splashRadius: 16,
      onSelected: (String choice) {
        // Handle the choice selected from the menu
        if (choice == 'Edit') {
          Get.to(EditEvent(eventId: eventId));
        } else if (choice == 'Update Status') {
          //this function event data that is fetched from getEvents
          openAnimatedDialog(
            context: context,
            type: type,
            owner: owner,
            title: title,
            venue: venue,
            description: description,
            eventId: eventId,
            startDate: startDate,
            endDate: startDate,
            status: status,
          ); //call dialog
        } else if (choice == 'Cancel') {
          cancelEvent(
            context: context,
            type: type,
            owner: owner,
            title: title,
            venue: venue,
            description: description,
            eventId: eventId,
            startDate: startDate,
            endDate: startDate,
            status: status,
          ); //call dialog
        }
      },
      itemBuilder: (BuildContext context) {
        if (status == 'Cancelled') {
          // Only show if the event is cancelled
          return [
            const PopupMenuItem<String>(
              value: 'Update Status',
              child: Text('Restore Event'),
            ),
          ];
        } else {
          // Show all options if the event is not cancelled
          return [
            const PopupMenuItem<String>(
              value: 'Edit',
              child: Text('Edit'),
            ),
            const PopupMenuItem<String>(
              value: 'Update Status',
              child: Text('Update status'),
            ),
            const PopupMenuItem<String>(
              value: 'Cancel',
              child: Text('Cancel event'),
            ),
          ];
        }
      },
    );

String formatDateTime(String date) {
  try {
    final parsedDate = DateTime.parse(date);
    final formattedDate = DateFormat('MMM dd yyyy HH:mm').format(parsedDate);
    return formattedDate;
  } catch (e) {
    //unexpected date format
    return 'Invalid Date $date';
  }
}
