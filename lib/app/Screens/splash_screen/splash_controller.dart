import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_property/app/Routes/app_pages.dart';
import 'package:get/get.dart';

import '../../Constants/app_constance.dart';
import '../../Constants/get_storage.dart';

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
        getData(AppConstance.authorizationToken) == null
            ? Get.offNamed(Routes.login)
            : Get.offAllNamed(Routes.property);
      },
    );

    WidgetsFlutterBinding.ensureInitialized();
  }
}
