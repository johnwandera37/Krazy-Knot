import '../../../utils/export_files.dart';
// import '../../utils/images.dart';

class GuestTab extends StatelessWidget {
  final String? eventId;

  GuestTab({required this.eventId});

  final EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    var screenHeight = Get.height;
    var screenWidth = Get.width;
    var event_id = eventId;

    return Scaffold(backgroundColor: Colors.white,

        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: const BackButton(color: Colors.black),
          centerTitle: true,
          title: 
          const Text(
            "Guest List",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            eventController.fetchMembers(event_id);
          },
          child: FutureBuilder(
            future: eventController.fetchMembers(event_id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                return Scaffold(
                    body: Center(
                        child: Text('Error fetching data: ${snapshot.error}')));
              } else {
                // Data fetched successfully, display the guest list
                var guests = eventController.attendees;
                if (guests.isEmpty) {
                  return const Scaffold(
                      body: Center(child: Text('No guests found for this event')));
                } else {
                  return Material(
                      child: ListView(
                    children: guests.map((guest) {
                      return Card(
                          child: ListTile(
                        title: Text(guest.attendeeName),
                        subtitle: Text(guest.attendeePhone),
                      ));
                    }).toList(),
                  ));
                }
              }
            },
          ),
        ));
  }
}
