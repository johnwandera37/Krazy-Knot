import 'package:photomanager/utils/images.dart';

import '../../../utils/export_files.dart';

class EditEvent extends StatefulWidget {
  // const EditEvent({super.key});
  final String eventId;
   EditEvent({required this.eventId, Key? key}) : super(key: key);

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
 final MapPickerController mapPickerController = Get.put(MapPickerController());
  late final ApiService apiService;
  final EventController eventController = Get.put(EventController());//for the events api
  final DateTimeController dateTimeController = Get.put(DateTimeController());//for the selected date variable
  final EventIdController eventIdController = Get.put(EventIdController());//for PUT reqquest data


  @override
  void initState() {
    super.initState();
    apiService = ApiService();//for the http APIs
     eventIdController.setEventId(widget.eventId);
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
    Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              "Edit Event",
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
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Fill the following details to edit the event",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                InputField(
                  hintText: "Enter event title",
                  controller: eventController.eventTitle,
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedDropdownValue,
                  items: dropdownItems.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: handleDropdownChange,
                  decoration: InputDecoration(
                    labelText: 'Select type of event',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () => Get.to(MapPicker()),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Select Location',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        mapPickerController.address.value,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomText(headingStr: "From"),
                SizedBox(height: 20),
                DateTimePicker(
                  initialDateTime: selectedDateTime,
                  onChanged: (dateTime) {
                    setState(() {
                      selectedDateTime = dateTime;
                      dateTimeController
                          .updateSelectedDateTimeStart(selectedDateTime);
                    });
                  },
                ),
                SizedBox(height: 20),
                CustomText(headingStr: "To"),
                SizedBox(height: 20),
                DateTimePicker(
                  initialDateTime: selectedDateTime,
                  onChanged: (dateTime) {
                    setState(() {
                      selectedDateTime = dateTime;
                      dateTimeController
                          .updateSelectedDateTimeEnd(selectedDateTime);
                    });
                  },
                ),
                SizedBox(height: 20),
                InputField(
                  hintText: "Enter event description",
                  maxLines: 5,
                  controller: eventController.eventDescription,
                ),
                SizedBox(height: 30),
                FractionallySizedBox(
                  widthFactor: 0.6, // Set to 60% of the screen width
                  child: Center(
                    child: CustomButton(
                      buttonStr: "Edit Event",
                      btncolor: Colors.blue,
                      onTap: () async {
                        eventController.editEvent();
                        Get.delete<MapPickerController>();
                        Get.delete<DateTimeController>();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}