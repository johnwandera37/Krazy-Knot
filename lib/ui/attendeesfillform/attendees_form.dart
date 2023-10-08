import 'package:photomanager/utils/export_files.dart';
import '../../utils/images.dart';

class InvitationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EventController eventController = Get.put(EventController());
    var screenWidth = Get.width;
    var screenHeight = Get.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
              const CustomText(
                headingStr:
                    "Hello there,\nHOST has invited you to join: EVENT NAME At: EVENT VENUE On: EVENT DATE",
                fontSize: 16,
                weight: TextWeight.bold,
              ),
              sizedHeight(20),
              const CustomText(
                headingStr:
                    "Fill in your details below to book a spot for yourself",
                fontSize: 16,
                weight: TextWeight.bold,
              ),
              sizedHeight(20),
              Eventnput(
                hintText: "Your Name",
                textEditingController: eventController.attendeeNameStr,
              ),
              sizedHeight(20),
              Eventnput(
                hintText: "Phone details",
                textEditingController: eventController.attendeePhoneNo,
              ),
              sizedHeight(30),
              CustomButton(
                buttonStr: "Submit",
                onTap: () {
                  eventController.addAttendeesData(); //add attendees
                  Get.back();
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
