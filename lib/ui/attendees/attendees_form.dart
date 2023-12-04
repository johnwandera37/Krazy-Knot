import 'package:photomanager/utils/export_files.dart';
import '../../utils/images.dart';
import 'package:intl/intl.dart';

class InvitationForm extends StatelessWidget {
  final String? eventId;
  final String? title;
  final String? owner;
  // final String? type;
  final String? venue;
  // final String? description;
  final String? startDate;
  final String? endDate;

  InvitationForm({
    this.eventId,
    this.title,
    this.owner,
    // this.type,
    this.venue,
    // this.description,
    this.startDate,
    this.endDate,
  });

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

  @override
  Widget build(BuildContext context) {
    final EventController eventController = Get.put(EventController());
    var screenWidth = Get.width;
    var screenHeight = Get.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Center(
          child: Text(
            "Invitation Form",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                Images.joinus,
                height: screenHeight * .25,
                width: screenWidth * .9,
              ),
              sizedHeight(20),
              Column(children: [
                Text(
                    "Hello there,\nYou have been invited to join event: $title\nAt: $venue\nOn: ${formatDateTime(startDate!)}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 15)),
                sizedHeight(20),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Fill in your details below to book a spot for yourself",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15))),
              ]),
              sizedHeight(30),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Name:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue))),
              sizedHeight(10),
              TextField(
                decoration: const InputDecoration(
                  hintText: "e.g. John Doe",
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                controller: eventController.attendeeNameStr,
              ),
              sizedHeight(30),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Phone:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.blue),
                  )),
              sizedHeight(10),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "e.g. 0712345678",
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                controller: eventController.attendeePhoneNo,
              ),
              sizedHeight(40),
              CustomButton(
                buttonStr: "Submit",
                onTap: () {
                  var event_id = eventId;
                  eventController.addAttendeesData(event_id);
                },
                btncolor: Colors.blue,
              )
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
