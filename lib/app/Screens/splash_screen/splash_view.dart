import 'package:flutter/material.dart';
import 'package:flutter_property/app/Screens/splash_screen/splash_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
        body: Column(
          children: [
            Text('1232456'),
            Row(
              children: [
                for (int i = 1; i < 4; i++) NumberBubble(i),
              ],
            ),
            Row(
              children: [
                for (int i = 4; i < 7; i++) NumberBubble(i),
              ],
            ),
            Row(
              children: [
                for (int i = 6; i < 10; i++) NumberBubble(i),
              ],
            ),
            Center(
              child: NumberBubble(0),
            )
          ],
        ));
  }

  Widget NumberBubble(int number) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(number.toString()),
    );
  }
}
