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
    double screenWidth = Get.width;
    double screenHeight = Get.height;

    //using a function to filter events
    List<Event> filterFeaturedEvents(List<Event> allEvents) {
      final now = DateTime.now();
      final startOfWeek = DateTime(now.year, now.month, now.day);
      final endOfWeek = startOfWeek.add(Duration(days: 7));
      // Filter the events that fall within the upcoming week
      final featuredEvents = allEvents.where((event) {
        final eventDate =
            DateTime.parse(event.eventStartDate); // Parse the event date
        return eventDate.isAfter(startOfWeek) && eventDate.isBefore(endOfWeek);
      }).toList();
      return featuredEvents;
    }

    return Obx(() => Scaffold(
          backgroundColor: HexColor("F7F7F7"),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: SingleChildScrollView(
              // padding: EdgeInsets.only(bottom: screenHeight * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                      child: CustomText(
                          headingStr: "My Events",
                          fontSize: 16,
                          weight: TextWeight.bold)),
                  sizedHeight(screenHeight * 0.02),
                  const CustomText(
                      headingStr: 'Upcoming Events',
                      fontSize: 16,
                      weight: TextWeight.semiBold),
                  sizedHeight(screenHeight * 0.04),
                  const CustomText(
                      headingStr: 'Click on an event to invite guests'),
                  filterFeaturedEvents(eventController.events).isEmpty
                      ? Center(
                          child: Container(
                            width: screenWidth * 0.5,
                            height: screenHeight * 0.95,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  headingStr:
                                      "Your Upcoming events will appear here",
                                  fontSize: 15,
                                ),
                                sizedHeight(screenHeight * 0.04),
                                Image.asset(
                                  Images.featured,
                                  width: screenWidth * 0.5,
                                  height: screenHeight * 0.5,
                                  fit: BoxFit.fill,
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(
                          height: screenHeight * 0.28,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                filterFeaturedEvents(eventController.events)
                                    .length,
                            itemBuilder: (BuildContext context, int index) {
                              final event = filterFeaturedEvents(
                                  eventController.events)[index];
                              return Container(
                                width: screenWidth * 0.8,
                                height: screenHeight * 0.5,
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.02,
                                  vertical: screenHeight * 0.02,
                                ),
                                child: eventTile(
                                  eventType: event.eventType,
                                  eventTitle: event.eventName,
                                  eventDate:
                                      '${formatDateTime(event.eventStartDate!)} - ${formatDateTime(event.eventEndDate!)}',
                                  eventId: event.id.toString(),
                                  eventDescription: event.eventDescription,
                                ),
                              );
                            },
                          ),
                        ),
                  sizedHeight(screenHeight * 0.03),
                  Row(
                    children: const [
                      CustomText(
                          headingStr: 'Other Events',
                          fontSize: 16,
                          weight: TextWeight.semiBold),
                    ],
                  ),
                  sizedHeight(screenHeight * 0.02),
                  const CustomText(
                      headingStr: 'Click on an event to invite guests'),
                  sizedHeight(screenHeight * 0.02),
                  SizedBox(
                    height: eventController.events.isEmpty
                        ? screenHeight * 0.5
                        : screenHeight * 0.4,
                    child: eventController.events.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  headingStr:
                                      "You don't have any events created",
                                  fontSize: 15,
                                ),
                                SizedBox(height: screenHeight * 0.04),
                                Image.asset(
                                  Images.empty,
                                  width: screenWidth * 0.3,
                                  height: screenHeight * 0.3,
                                  fit: BoxFit.fill,
                                ),
                              ],
                            ),
                          )
                        : ListView(
                            children: eventController.events.map((event) {
                              return SizedBox(
                                width: screenWidth,
                                child: eventTile(
                                  eventType: event.eventType,
                                  eventTitle: event.eventName,
                                  eventDate:
                                      '${formatDateTime(event.eventStartDate!)} - ${formatDateTime(event.eventEndDate!)}',
                                  eventId: event.id.toString(),
                                  eventDescription: event.eventDescription,
                                ),
                              );
                            }).toList(),
                          ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {
              Get.to(CreateEvent());
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ));
  }
}

//event tile
Widget eventTile({
  required eventType,
  required eventTitle,
  required eventDate,
  VoidCallback? onTap,
  required String eventId,
  required String eventDescription,
}) {
  final Map<String, String> eventTypeToImage = {
    'Technology': Images.technology,
    'Education': Images.education,
    'Business': Images.business,
    'Food': Images.food,
    'Wedding': Images.wedding,
    'Sports': Images.sports,
  };

  final String imagePath = eventTypeToImage[eventType] ?? Images.event;

  double screenWidth = Get.width;
  double screenHeight = Get.height;
  double imageWidth = 50;
  double imageHeight = 50;
  double textSize = 16;

  return InkWell(
    onTap: onTap,
    child: Container(
      width: screenWidth,
      decoration: inputDecoration(),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02, horizontal: screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    CustomImage(
                        image: imagePath,
                        imageWidth: imageWidth,
                        imageHeight: imageHeight),
                    sizedWidth(screenWidth * 0.02),
                    CustomText(
                        headingStr: eventType,
                        fontSize: textSize,
                        weight: TextWeight.semiBold),
                  ],
                ),
                Spacer(),
                Container(child: PopUpMenu(eventId: eventId.toString())),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            CustomText(headingStr: eventTitle, fontSize: textSize),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            CustomText(headingStr: eventDescription, fontSize: textSize),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: CustomText(
                  headingStr: eventDate,
                  fontColor: HexColor("151515"),
                  fontSize: textSize * 0.7),
            ),
          ],
        ),
      ),
    ),
  );
}

//PopUPMenu
Widget PopUpMenu({
  // required VoidCallback onEdit, // Add the onEdit callback
  required String eventId, // Add eventId parameter
}) =>
    PopupMenuButton<String>(
      iconSize: 17,
      splashRadius: 16,
      onSelected: (String choice) {
        // Handle the choice selected from the menu
        if (choice == 'Edit') {
          // onEdit(eventId);
          Get.to(EditEvent(eventId: eventId));
        } else if (choice == 'Update Status') {
        } else if (choice == 'Cancel Event') {}
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
