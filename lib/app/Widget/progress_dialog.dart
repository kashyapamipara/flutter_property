import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constants/color.dart';

class ProgressDialog {
  static var isOpen = false;

  static showProgressDialog(bool showDialog) {
    if (showDialog) {
      isOpen = true;
      print('|--------------->🕙️ Loader start 🕑️<---------------|');

      Get.dialog(
        WillPopScope(
          onWillPop: () => Future.value(true),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: AppColors.PRIMARY_COLOR,
                )
              ],
            ),
          ),
        ),
        barrierDismissible: false, /*useRootNavigator: false*/
      );
    } else if (Get.isDialogOpen!) {
      print('|--------------->🕙️ Loader end 🕑️<---------------|');
      Get.back();

      isOpen = false;
    }
  }
}

