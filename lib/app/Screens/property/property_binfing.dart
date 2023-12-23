import 'package:flutter_property/app/Screens/property/property_controller.dart';
import 'package:get/get.dart';

class PropertyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PropertyController());
  }
}
