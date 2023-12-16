import '../../../utils/export_files.dart';
import 'package:share_plus/share_plus.dart';

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
}) {
  // void goToInvitation() {
  //   Get.to(InvitationForm(
  //     eventId: eventId,
  //     title: title,
  //     owner: owner,
  //     // type: type,
  //     venue: venue,
  //     // description: description,
  //     startDate: startDate,
  //     endDate: endDate,
  //   ));
  // }

  void goToGuests() {
    Get.to(GuestTab(eventId: eventId));
  }

  Future<String> getLink(eventId) async {
    try {
      final data = await ApiService().geteventLink(eventId);
      debugPrint('$data');
      final eventLnk = data['eventLink'] as String;
      return eventLnk;
    } catch (e) {
      debugPrint('$e');

      // Show error message as a snackbar
      Get.snackbar(
        'Error',
        '$e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      // Return a default value or handle the error gracefully
      return '';
    }
  }

  onTap({required eventId}) async {
    String shareContent = await getLink(eventId);
    Share.share(shareContent);
  }

  bool isReady = status?.toLowerCase() == 'ready';

  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return Container();
    },
    transitionDuration: const Duration(milliseconds: 200),
    transitionBuilder: (context, a1, a2, child) => ScaleTransition(
      scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
        child: AlertDialog(
          title: const CustomText(
            headingStr: 'Event is ready',
            fontSize: 17,
            weight: TextWeight.bold,
          ),
          content: SizedBox(
            width: Get.width * .5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomText(
                  headingStr: "Share a link to to invite guests to your event",
                  fontSize: 15,
                ),
                sizedHeight(20),
                Center(
                  child: CustomButton(
                    buttonStr: "Share link",
                    btncolor: isReady
                        ? Colors.blue
                        : Colors.grey, // Change button color based on status
                    onTap: isReady
                        ? () {
                            onTap(eventId: eventId);
                          }
                        : () {}, // Set onTap to null if not ready
                  ),
                ),
                sizedHeight(10), 
                // Center(
                //   child: CustomButton(
                //       buttonStr: "Open form",
                //       btncolor: Colors.blue,
                //       onTap: goToInvitation),
                // ),
                // sizedHeight(10),
                Center(
                    child: TextButton(
                  child: const Text('View guests'),
                  onPressed: () {
                    goToGuests();
                  },
                )),
                sizedHeight(5),
                Center(
                    child: TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Get.back();
                  },
                ))
              ],
            ),
          ),
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none),
          // actions: [
          //   Center(
          //       child: TextButton(
          //     child: const Text('Close'),
          //     onPressed: () {
          //       Get.back();
          //     },
          //   )),
          // ],
        ),
      ),
    ),
  );
}
