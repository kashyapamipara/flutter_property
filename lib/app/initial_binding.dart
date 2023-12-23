
import 'package:flutter_property/app/Screens/property/property_controller.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InitialBinding());
        Get.lazyPut(() => PropertyController());
  }
}
