import '../../../utils/export_files.dart';

// class GuestTab extends StatelessWidget {
//   final String? eventId;

//   GuestTab({required this.eventId});

//   final EventController eventController = Get.put(EventController());
//   final EventIdController eventIdController = Get.put(EventIdController()); 
//   //  late int totalUsers; 
//   // var totalUsers = 0.obs;

//   @override
//   Widget build(BuildContext context) { 
   

//     var screenHeight = Get.height;
//     var screenWidth = Get.width;
//     var event_id = eventId;

//     return Scaffold(backgroundColor: Colors.white,

//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           leading: const BackButton(color: Colors.black),
//           centerTitle: true,
//           title: 
//           const Text(
//             "Guest List",
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         body: RefreshIndicator(
//           onRefresh: () async {
//              eventController.fetchMembers(event_id);
//               // Fetch members and update the totalUsers variable

//           },
//           child: 
//           FutureBuilder(
//             future: eventController.fetchMembers(event_id),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Scaffold(
//                     body: Center(child: CircularProgressIndicator()));
//               } else if (snapshot.hasError) {
//                 return Scaffold(
//                     body: Center(
//                         child: Text('Error fetching data: ${snapshot.error}')));
//               } else {
//                 // Data fetched successfully, display the guest list
//                 var guests = eventController.attendees;
//                 // totalUsers.value = guests.length;
//                 eventIdController.updateTotalUsers(guests.length);
//                 // debugPrint('🙋‍♂️🙋‍♂️🙋‍♂️$totalUsers');
//                 if (guests.isEmpty) {
//                   return const Scaffold(
//                       body: Center(child: Text('No guests found for this event')));
//                 } else {
//                   return Material(
//                       child: ListView(
//                     children: guests.map((guest) {
//                       return 
//                       AttendeesTile(name: guest.attendeeName, phone: guest.attendeePhone);
//                       // Card(
//                       //     child: ListTile(
//                       //   title: Text(guest.attendeeName),
//                       //   subtitle: Text(guest.attendeePhone),
//                       // ));
//                     }).toList(),
//                   ));
//                 }
//               }
//             },
//           ),
//         ));
//   }
// }

class GuestTab extends StatefulWidget{
   final String? eventId;

    const GuestTab({
      super.key, 
      required this.eventId,
      });
   
  @override
  State<GuestTab> createState() => _GuestTabState();
}

class _GuestTabState extends State<GuestTab> {
    //  var attendeesRepo = AttendeesRepo(apiClient: Get.find());
     final EventIdController eventIdController = Get.put(EventIdController()); //for the number of attendees

  @override
  Widget build(BuildContext context) {
  //  var attendeescontroller = Get.put(AttendeesController(attendeesRepo: attendeesRepo));
   return 
   Obx(() =>
   Scaffold(
    // backgroundColor: Colors.white,
     appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconWidget(icon:  Icons.arrow_back, bacIconColor: HexColor('F8DFD4'),
          onTap: (){
              Get.back();
            }),
          centerTitle: true,
          title: 
          const CustomText(headingStr: "Guest List", fontSize: 20, weight: TextWeight.bold,)
        ),
        body: 
        
        RefreshIndicator(
             onRefresh: () async {
                await attendeescontroller.attendeesData(widget.eventId);
        setState(() {
          attendeescontroller.attendeesModel!.attendee;
        });
      },
          child: attendeescontroller.loadingAttendeesData.value?
                     Center(
                  child: CircularProgressIndicator(
                    color: HexColor('87C4FF')
                  ),
                ):
                buildAttendeeList()
          ),
   )
   );
  }


  Widget buildAttendeeList(){
  if(attendeescontroller.attendeesModel == null || attendeescontroller.attendeesModel!.attendee.isEmpty){
    return const Center(
        child: CustomText(
          headingStr: "No guests found for this event",
          weight: TextWeight.semiBold,
          fontSize: 17,
        ),
      );
  }else{
        debugPrint('🎉🎉🎉Check number of attendee  🙋‍♂️🙋‍♂️+++++++ ${attendeescontroller.attendeesModel!.attendee.length}');
        // var numberOfInvitedGuests = attendeescontroller.attendeesModel!.attendee.length;
        
      return
        ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: attendeescontroller.attendeesModel!.attendee.length,
          itemBuilder: (BuildContext context, int index) {
            AttendeesCard attendeesCard =  attendeescontroller.attendeesModel!.attendee[index];
            return AttendeesTile(attendeesCard: attendeesCard);
          },
        );
  }
}
}

  