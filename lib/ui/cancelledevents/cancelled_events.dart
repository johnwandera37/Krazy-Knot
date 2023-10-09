import '../../utils/export_files.dart';
import '../../utils/images.dart';

class CancelledEvents extends StatefulWidget {
  const CancelledEvents({super.key});

  @override
  State<CancelledEvents> createState() => _CancelledEventsState();
}

class _CancelledEventsState extends State<CancelledEvents> {
  final EventController eventController = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    var screenWidth = Get.width;
    var screenHeight = Get.height;

    final List<Event> cancelledEvents = eventController.events
        .where((event) => event.eventStatus.toLowerCase() == "cancelled")
        .toList();

    return Scaffold(
  body: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Cancelled Events",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          sizedHeight(20),
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
  ),
);

  }
}