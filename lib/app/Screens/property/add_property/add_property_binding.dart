import 'package:get/get.dart';

import 'add_property_controller.dart';

class AddPropertyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AddPropertyController());
  }
}
