import '../utils/export_files.dart';

class MapPickerController extends GetxController {
  final RxString address = ''.obs;

  void setAddress(String newAddress) { 
    address.value = newAddress;
  }
}