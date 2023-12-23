import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Routes/app_pages.dart';


class SplashController extends GetxController {
  var change = true.obs;
  var changeIs = 0.obs;
  var context;


  @override
  Future<void> onInit() async {
    super.onInit();
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        Get.offNamed(Routes.property);
      },
    );

    WidgetsFlutterBinding.ensureInitialized();
  }
}
