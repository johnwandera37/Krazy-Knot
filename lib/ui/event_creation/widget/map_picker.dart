import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

import '../../../utils/export_files.dart';
class MapPicker extends StatefulWidget{
  const MapPicker({super.key});

  @override
  State<MapPicker> createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  final MapPickerController mapPickerController = Get.put(MapPickerController());
  // TextEditingController locationAddressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    body: OpenStreetMapSearchAndPick(
        center: LatLong(23, 89),
        buttonColor: Colors.blue,
        buttonText: 'Select location',
        hintText: 'Search event  location',
        onPicked: (pickedData) {
          setState(() {
            String address = pickedData.address.toString();
           mapPickerController.setAddress(address); // Update address using GetX
          });
          print('latitude ********************* ${pickedData.latLong.latitude}');
          print('logitude *********************${pickedData.latLong.longitude}');
          print('address *********************${pickedData.address}');
           Navigator.of(context).pop();//navigate back
        }),
        );
}
//  @override
//   void dispose() {
  
//     super.dispose();
//   }
}
