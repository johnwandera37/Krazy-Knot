import 'package:photomanager/controllers/profile_controller.dart';

import '../../../utils/export_files.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final MapPickerController mapPickerController = Get.put(MapPickerController());
  late final ApiService apiService;
  final EventController eventController = Get.put(EventController()); //for the events api
  final DateTimeController dateTimeController = Get.put(DateTimeController()); //for the selected date variable
  
  

  @override
  void initState() {
    super.initState();
    apiService = ApiService(); //for the http APIs
  }

//the drop down
  String? selectedDropdownValue;
  List<String> dropdownItems = [
    'Food',
    'Education',
    'Technology',
    "Sports",
    "Business",
    "Wedding"
  ];

  //dte and time
  DateTime selectedDateTime = DateTime.now();

  void handleDropdownChange(String? value) {
    setState(() {
      selectedDropdownValue = value;
      eventController.selectType.text = value ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
     initUserId() async {
                var controller = Get.find<ProfileController>();
                var profileData = await controller.profileData();
                debugPrint(
                    'NEW USER IDDDD :::::::  ${controller.userInfo!.id}');
                var user_id = controller.userInfo!.id;
                return user_id;
              }
             var  user = initUserId();
    
    return 
    WillPopScope(
       onWillPop: () async {
      // Clear text editing controllers, map value and date value when back button is pressed
      Get.delete<MapPickerController>();
      Get.delete<DateTimeController>();
        Get.delete<EventController>();
        return true; // Allow back navigation
      },
      child: Obx(
        () => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Center(
              child: Text(
                "Create Event",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Event Title',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: "Enter event title",
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black),
                      ),
                    ),
                    controller: eventController.eventTitle,
                  ),
                  const SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          'Event Type',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text('Select an event type'),
                            value: selectedDropdownValue,
                            items: dropdownItems.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: handleDropdownChange,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Event Location',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () => Get.to(const MapPicker()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                mapPickerController.address.value.isEmpty
                                    ? 'Select Location'
                                    : mapPickerController.address.value,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const Icon(Icons.location_on,
                              color: Colors
                                  .black),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'From',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  DateTimePicker(
                    initialDateTime: selectedDateTime,
                    onChanged: (dateTime) {
                      setState(() {
                        selectedDateTime = dateTime;
                        dateTimeController.updateSelectedDateTimeStart(selectedDateTime);
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'To',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  DateTimePicker(
                    initialDateTime: selectedDateTime,
                    onChanged: (dateTime) {
                      setState(() {
                        selectedDateTime = dateTime;
                        dateTimeController.updateSelectedDateTimeEnd(selectedDateTime);
                      });
                    },
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Event Description',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  InputField(
                    hintText: "Enter event description",
                    maxLines: 5,
                    controller: eventController.eventDescription,
                  ),
                  const SizedBox(height: 30),
                  FractionallySizedBox(
                    widthFactor: 0.6, // Set to 60% of the screen width
                    child: Center(
                      child: CustomButton(
                        buttonStr: "Create Event",
                        btncolor: Colors.blue,
                        onTap: () async {
                          eventController.createEvent(user);
                          eventController.fetchEvents(user);
                          Get.back();
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String? hintText;
  final int? maxLines;
  final TextEditingController? controller;

  const InputField({this.hintText, this.maxLines, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines ?? 1,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
