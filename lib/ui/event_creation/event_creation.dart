import 'package:photomanager/utils/images.dart';

import '../../utils/export_files.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
 final MapPickerController mapPickerController = Get.put(MapPickerController());
  late final ApiService apiService;
  final EventController eventController = Get.put(EventController());//for the events api
  final DateTimeController dateTimeController = Get.put(DateTimeController());//for the selected date variable


  @override
  void initState() {
    super.initState();
    apiService = ApiService();//for the http APIs
    
  }

//the drop down
  String? selectedDropdownValue;
  List<String> dropdownItems = ['Food', 'Education', 'Technology', "Sports", "Business", "Wedding"];

  //dte and time
  DateTime selectedDateTime = DateTime.now();

  void handleDropdownChange(String? value) {
    setState(() {
      selectedDropdownValue = value;
      eventController.selectType.text = value ?? "";
      dateTimeController.updateSelectedDateTimeStart(selectedDateTime);
      dateTimeController.updateSelectedDateTimeEnd(selectedDateTime);
    });
  }


  @override
  Widget build(BuildContext context) {
    return 
    Obx(() => 
    Scaffold(
      backgroundColor: HexColor("F7F7F7"),
      appBar: AppBar(
      elevation: 0,
      backgroundColor: HexColor("F7F7F7"),
      title: const Center(child: CustomText(headingStr: "Create Event", fontSize: 18, weight: TextWeight.semiBold,)),
      ),
      body:SingleChildScrollView(
        child: 
        Container(
          margin: EdgeInsets.only(bottom: 50),
          child: Column(
            children: [
              //Fill description
              const CustomText(headingStr: "Fill the following details to create an event", fontSize: 16, weight: TextWeight.semiBold,),
              sizedHeight(20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(20),
                decoration: inputDecoration(),
                child: Column(children: [
                  //title
                  Eventnput(hintText: "Enter event title", vertPadding: 8, textEditingController: eventController.eventTitle,),
                  //select type
                  Eventnput(hintText: "Select type of event",
                  textEditingController: eventController.selectType,
                  dropdownItems: dropdownItems, 
                  selectedDropdownValue: selectedDropdownValue, 
                  onDropdownChanged: handleDropdownChange,
                  ),
                   sizedHeight(20),
                  //location
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: InkWell(
                      onTap: ()=>Get.to(MapPicker()),
                      child: InputDecorator(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Select Location',
                            border: OutlineInputBorder(
                              borderRadius:  BorderRadius.circular(10)
                            ),
                          ),
                          child: CustomText(
                            headingStr: mapPickerController.address.value, fontSize: 16,
                            onTap: () => Get.to(MapPicker()
                          ),
                        ),
                        ),
                    ),
                  ),
                  sizedHeight(20),
                ]),
              ),
              sizedHeight(20),
              //date and time
                 Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(20),
                decoration: inputDecoration(),
                child: Column(children: [
                CustomText(headingStr: "From"),
                sizedHeight(20),
                DateTimePicker(
                  initialDateTime: selectedDateTime,
                  onChanged: (dateTime) {
                    setState(() {
                      selectedDateTime = dateTime;
                      dateTimeController.updateSelectedDateTimeStart(selectedDateTime);
                      print('==========================================FROM DATE');
                      print(selectedDateTime);
                    });
                  },
                ),
                 sizedHeight(20),
                 CustomText(headingStr: "To"),
                 sizedHeight(20),
                DateTimePicker(
                  initialDateTime: selectedDateTime,
                  onChanged: (dateTime) {
                    setState(() {
                      selectedDateTime = dateTime;
                      dateTimeController.updateSelectedDateTimeEnd(selectedDateTime);
                       print('==========================================TO DATE');
                      print(selectedDateTime);
                    });
                  },
                ),
        
                ]),
              ),
        
                sizedHeight(20),
                //description
                 Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(20),
                decoration: inputDecoration(),
                child: Column(children: [
                
               Eventnput(hintText: "Enter event description", maxLines: 5, textEditingController: eventController.eventDescription,)
                ]),
              ),

              sizedHeight(30),
              //create button
              CustomButton(buttonStr: "Create event", btncolor: Colors.blue, onTap: () async {
                //apiService.addEvent(request);
                // eventController. addAttendeesData();//just a test
                // eventController. fetchMembers();//just a test
                eventController.createEvent();//create event
                 Get.delete<MapPickerController>();
                 Get.delete< DateTimeController>();
                
              })
            ],
          ),
        ),
      )
    )
    );
  }
}