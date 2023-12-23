import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'color.dart';

class Utils {
  static void warningMessage(String message) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        "Warning!",
        message, /* backgroundColor: ThemeColors.colorWarningMessage, colorText: Colors.black*/
      );
    }
  }

  static void warningMessageWithTitle({String? title, String? message}) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        title ?? "Warning!",
        message!,
      );
    }
  }

  static void handleNetworkError(message) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        "Error",
        message,
      );
    }
  }

  /// new added
  static void validationCheck({message, title = "Error", isExpandedMargin = false}) {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
        margin: EdgeInsets.only(bottom: isExpandedMargin ? 12.h : 20, left: 10, right: 10),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: title == 'Error' ? AppColors.RED_COLOR : AppColors.PRIMARY_COLOR,
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
        messageText: Row(
          children: [
            Icon(
              title == 'Error' ? Icons.error_rounded : Icons.check_circle,
              color: AppColors.WHITE_COLOR,
              size: 24,
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Text(
                message ?? 'Empty message',
                style: TextStyle(
                  color: AppColors.WHITE_COLOR,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
        borderRadius: 99,
        duration: const Duration(milliseconds: 1500),
      );
    }
  }
}
