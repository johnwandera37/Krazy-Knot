import 'package:photomanager/controllers/profile_controller.dart';

import '../../../utils/export_files.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final MapPickerController mapPickerController = Get.put(MapPickerController());//for the selected map address
  final DateTimeController dateTimeController = Get.put(DateTimeController()); //for the selected date variable
  FormValidator formValidator = FormValidator();//validations
  final eventcontroller = Get.find<EventsController>();
  


//the drop down
  String? selectedDropdownValue;
  List<String> dropdownItems = [
    'Food',
    'Education',
    'Technology',
    "Sports",
    "Business",
    "Wedding",
    "Entertainment",
  ];

  //date and time
  DateTime selectedDateTime = DateTime.now();

  void handleDropdownChange(String? value) {
    setState(() {
      selectedDropdownValue = value;
      eventcontroller.selectType.text = value ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
     
    return 
      Obx(() => 
      Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: true,
            leading:   IconWidget(icon:  Icons.arrow_back, onTap: (){
              Get.back();
        }),
            title: const Text(
              "Create Event",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter event title",
                       border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                        ),
                    ),
                    controller: eventcontroller.title,
                  ),
                  const SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration:  BoxDecoration(
                            border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: selectedDropdownValue == null?const Text('Select an event type'):Text('$selectedDropdownValue'),
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
                  InkWell(
                    onTap: () => Get.to(const MapPicker()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration:  BoxDecoration(
                         border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
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
                  sizedHeight(30),
                  const CustomText(headingStr: 'From', align: TextAlignOption.center,fontSize: 16, weight: TextWeight.bold,), 
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
                   const CustomText(headingStr: 'To', align: TextAlignOption.center,fontSize: 16, weight: TextWeight.bold,), 
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
                  InputField(
                    hintText: "Enter event description",
                    maxLines: 5,
                    controller: eventcontroller.description,
                  ),
                  const SizedBox(height: 30),
                  FractionallySizedBox(
                    widthFactor: 0.6, // Set to 60% of the screen width
                    child: Center(
                      child: CustomButton(
                        buttonStr: "Create Event",
                        btncolor: HexColor('FFAD84'),
                        onTap: () async {
                           if (formValidator.validateFields( selectedDropdownValue: selectedDropdownValue, context: context)) { 
                            await eventcontroller.postEventData(context);//create event
                            await eventcontroller.eventData();//fetch event
                          }
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