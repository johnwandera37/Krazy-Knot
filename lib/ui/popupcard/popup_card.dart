import '../../../utils/export_files.dart';

 void popUpCard({
  required BuildContext context,
  String? eventId,
  String? status,
  String? title,
  String? owner,
  String? type,
  String? venue,
  String? description,
  String? startDate,
  String? endDate,
  }){
    showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2){
      return Container();
    },
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (context, a1, a2, child) => 
    ScaleTransition(
      scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
      child: 
      FadeTransition(
        opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
        child: AlertDialog(
          title: const CustomText(headingStr: 'Event is ready', fontSize: 17, weight: TextWeight.bold,),
          content: 
          Container(
            width: Get.width * .5,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(headingStr: "Share the link to to invite memberst to your event", fontSize: 15,),
              sizedHeight(20),
              Center(child: CustomButton(buttonStr: "share link", onTap: (){}),)
            ],
                  ),
          ),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          actions: [
                          TextButton(
                child: Text('Close'),
                onPressed: () {
                  Get.back();
                },
              ),
          ],
        ),
      ),
    ),
    );
  }