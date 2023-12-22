
import 'package:photomanager/ui/base/widgets/custom_image.dart';
import 'package:photomanager/utils/export_files.dart';

import '../../../../utils/images.dart';

  class EventCardWidget extends StatelessWidget{
  final EventCard eventCard;

  const EventCardWidget({super.key, required this.eventCard});
      @override
      Widget build(BuildContext context) {
        var result = MyUtils().getTimeUntilEvent(eventCard.eventStartDate, eventCard.eventEndDate);
        int timeValue = result[0];
        String timeUnit = result[1];
        return
           SizedBox(
          height: Get.width*.8,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: Get.width*.73,
                  width: Get.width*.9,
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(color: HexColor('DDF2FD'),
                    borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            CustomText(headingStr: eventCard.eventName, weight: TextWeight.semiBold, fontSize: 16,),
                            sizedHeight(10),
                            // // MyUtils().formatTextWithWeight(MyUtils().formatTimeUntilEvent(eventCard.eventStartDate, eventCard.eventEndDate), 20, TextWeight.bold),
                            // CustomText(
                            // headingStr: '$timeValue',// MyUtils().formatTimeUntilEvent(eventCard.eventStartDate, eventCard.eventEndDate),
                            // fontSize: 30, weight: TextWeight.bold,),
                            // CustomText(headingStr: timeUnit)
                            MyUtils().formatTimeUntilEvent(eventCard.eventStartDate, eventCard.eventEndDate)
                            ],
                          ),
                      ]),
                    ),
                  ),
                ),
              Positioned(
                top: 0,
                child: Image.asset(Images.party, height:  210,),
              )
            ],
          ),
        );
      }
  }