import 'package:photomanager/utils/export_files.dart';

import '../../utils/images.dart';

class InvitationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final EventController eventController = Get.put(EventController());

    return Scaffold(
      appBar: AppBar(
        title: Center(child: CustomText(headingStr: "Event Invitation", fontSize: 16, weight: TextWeight.bold,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Images.joinus,
              height: 243,
              width: 253,
            ),
            CustomText(
              headingStr: "Hello there, Here's your invitation to join\nThe hackathon event at Malindi Hub!\n Time: Oct 23 2023 - Oct 23 2023\n Host: wandera@inet.africa", 
              fontSize: 16, weight: TextWeight.bold,),
            sizedHeight(20),
            CustomText(headingStr: "Fill in your details below to book a spot for yourself", fontSize: 16, weight: TextWeight.bold,),
            sizedHeight(20),
            Eventnput(hintText: "Your Name", textEditingController: eventController.attendeeNameStr,),
            sizedHeight(20),
            Eventnput(hintText: "Phone details", textEditingController: eventController.attendeePhoneNo,),
            sizedHeight(30),
            CustomButton(buttonStr: "Submit", 
            onTap: (){
              eventController. addAttendeesData();//add attendees
              Get.back();}, 
            btncolor: Colors.amber,)
          ],
        ),
      ),
    );
  }
}