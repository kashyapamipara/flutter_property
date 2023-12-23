import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_property/app/Screens/property/property_controller.dart';

class PropertyView extends GetView<PropertyController> {
  const PropertyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container();
    });
  }
}
