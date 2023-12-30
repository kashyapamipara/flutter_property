import 'package:flutter/material.dart';
import 'package:flutter_property/app/Constants/app_strings.dart';
import 'package:flutter_property/app/Screens/splash_screen/splash_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import '../../Constants/color.dart';

class SplashView extends StatefulWidget {
  SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SplashController _splashController = Get.find<SplashController>();
  var dataStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        height: Get.height,
        alignment: Alignment.center,
        width: Get.height,
        decoration: const BoxDecoration(color: Colors.green),
        child: Text(
          AppStrings.hello,
          style: TextStyle(color: AppColors.WHITE_COLOR, fontSize: 30.sp),
        ),
      ),
    );
  }
}
