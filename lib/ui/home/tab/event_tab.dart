import 'package:photomanager/ui/base/widgets/custom_image.dart';
import 'package:photomanager/utils/images.dart';

import '../../../utils/export_files.dart';

class EventTab extends StatelessWidget {
  const EventTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("F7F7F7"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: 
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
            //title my events
            const Center(child: CustomText(headingStr: "My Events", fontSize: 16, weight: TextWeight.bold,)),
            sizedHeight(10),
            //featured events section
            const CustomText(headingStr: 'Featured Events', fontSize: 16, weight: TextWeight.semiBold,),
            sizedHeight(20),
            dummyEventList.isEmpty
              ? const Center(child: SizedBox(
                height: 100,
                child: Align(
                  alignment: Alignment.center,
                  child: CustomText(headingStr: "Your featured events will appear here", fontSize: 15))))
              :Container(
                height: 150,
               child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  final event = dummyEventList[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: eventTile(eventType: event['eventType'], eventTitle: event['eventTitle'], eventDate: event['eventDate']),
                  );
                },
                ),
             ),
            sizedHeight(30),
            //events section
            Row(children: const [
               CustomText(headingStr: 'Events', fontSize: 16, weight: TextWeight.semiBold,),
              ],),
            sizedHeight(20),
            //all events come here
           Center(
  child: dummyEventList.isEmpty
      ? const SizedBox(
                height: 100,
                child: Align(
                  alignment: Alignment.center,
                  child: CustomText(headingStr: "You don't have any events created", fontSize: 15)))
      : Wrap(
          spacing: 24.0,
          runSpacing: 24.0,
          children: dummyEventList.map((event) {
            return SizedBox(
              width: Get.width * 0.195, // Set the desired width for each eventTile
              child: eventTile(
                eventType: event['eventType']!,
                eventTitle: event['eventTitle']!,
                eventDate: event['eventDate']!,
              ),
            );
          }).toList(),
        ),
)


            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
        },
        child:const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}

//event tile
Widget eventTile({
    required eventType,
    required eventTitle,
    required eventDate,
     VoidCallback? onTap,
  
   }){
    //map that maps event types to image paths
    final Map<String, String> eventTypeToImage = {
    'Technology': Images.technology,
    'Education': Images.education,
    'Business': Images.business,
    'Food': Images.food,
    'Wedding': Images.wedding,
    'Sports': Images.sports,
  };
  final String imagePath = eventTypeToImage[eventType] ?? Images.event;//string that determine path based on event type
   return
    InkWell(
    onTap: onTap,
    child:
   Container(
    width: Get.width * .195,
    height: Get.width * .1,
    decoration: inputDecoration(),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 13),
      child: 
      Column(
         crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(children: [
          Row(children: [
          CustomImage(image: imagePath, imageWidth: 24, imageHeight: 24),
          sizedWidth(8),
          CustomText(headingStr: eventType, fontSize: 16, weight: TextWeight.semiBold,)
          ],),
          const Spacer(),
          Container(child: PopUpMenu())
        ],),
        //event title
        Container(
          height: 43,
          child: CustomText(headingStr: eventTitle, fontSize: 15,)),
        //date
        Align(
          heightFactor: 2,
           alignment: Alignment.bottomLeft, 
          child: CustomText(headingStr: eventDate, fontColor: HexColor("151515"), fontSize: 11,))
      ]),
      ),

)
    );
   }

//PopUPMenu
Widget PopUpMenu()=> PopupMenuButton<String>(
      iconSize: 17,
      splashRadius: 16,  
      onSelected: (String choice) {
        // Handle the choice selected from the menu
        if (choice == 'Edit') {
          
        } else if (choice == 'Update Status') {
          
        }
        else if (choice == 'Cancel') {
          
        }
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


// eventTile(eventType: "Technology", eventTittle: "The Ultimate Hackathon Challenge", eventDate: "26 Sep 2023"),
//my dummy list testing
List<Map<String, String>> dummyEventList = [
  {
    'eventType': 'Education',
    'eventTitle': 'Where Education Meets Fun',
    'eventDate': '27 Oct 2023',
  },
  {
    'eventType': 'Technology',
    'eventTitle': 'Tech Expo 2023',
    'eventDate': '15 Nov 2023',
  },
  {
    'eventType': 'Music',
    'eventTitle': 'Music Festival',
    'eventDate': '5 Dec 2023',
  },
  {
    'eventType': 'Sports',
    'eventTitle': 'Sports Championship',
    'eventDate': '20 Jan 2024',
  },
  {
    'eventType': 'Food',
    'eventTitle': 'Food Festival',
    'eventDate': '10 Feb 2024',
  },
  {
    'eventType': 'Business',
    'eventTitle': 'Business Conference',
    'eventDate': '5 Mar 2024',
  },
  {
    'eventType': 'Wedding',
    'eventTitle': 'Wedding Expo',
    'eventDate': '15 Apr 2024',
  },
  {
    'eventType': 'Sports',
    'eventTitle': 'Sports Championship',
    'eventDate': '20 Jan 2024',
  },
  {
    'eventType': 'Food',
    'eventTitle': 'Food Festival',
    'eventDate': '10 Feb 2024',
  },
  {
    'eventType': 'Business',
    'eventTitle': 'Business Conference',
    'eventDate': '5 Mar 2024',
  },
  {
    'eventType': 'Wedding',
    'eventTitle': 'Wedding Expo',
    'eventDate': '15 Apr 2024',
  },
];
