import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Constants/color.dart';

class ButtonWidget extends StatelessWidget {
  String? buttonText;
  VoidCallback onPressed;
  EdgeInsets? buttonMargin;
  EdgeInsets? buttonPadding;
  BorderRadius? borderRadius;
  Color? buttonColor;
  TextStyle? buttonTextStyle;
  double? buttonWidth;
  double? buttonHeight;
  ButtonStyle? elevatedButtonStyle;
  Widget? child;
  BorderSide? buttonBorderSide;
  double? buttonElevation;
  TextOverflow? textOverflow;
  bool isButtonWidthNull;
  bool isButtonHeightNull;

  ButtonWidget({
    Key? key,
    this.buttonText,
    required this.onPressed,
    this.buttonTextStyle,
    this.buttonMargin,
    this.buttonPadding,
    this.borderRadius,
    this.buttonColor,
    this.buttonHeight,
    this.buttonWidth,
    this.elevatedButtonStyle,
    this.child,
    this.buttonBorderSide,
    this.buttonElevation,
    this.textOverflow,
    this.isButtonWidthNull = false,
    this.isButtonHeightNull = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: buttonMargin ?? EdgeInsets.only(left: 5.w, right: 5.w),
      height: isButtonHeightNull ? buttonHeight : (buttonHeight ?? 6.h),
      width: isButtonWidthNull ? buttonWidth : (buttonWidth ?? MediaQuery.of(context).size.width),
      child: ElevatedButton(
        onPressed: onPressed,
        style: elevatedButtonStyle ??
            ElevatedButton.styleFrom(
              elevation: buttonElevation ?? 0,
              padding: buttonPadding ?? EdgeInsets.zero,
              backgroundColor: buttonColor ?? AppColors.PRIMARY_COLOR,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(8),
                side: buttonBorderSide ?? const BorderSide(style: BorderStyle.none),
              ),
            ),
        child: child ??
            Text(
              buttonText ?? 'Button',
              textAlign: TextAlign.center,
              overflow: textOverflow,
              style: buttonTextStyle ??
                  TextStyle(
                    color: AppColors.WHITE_COLOR,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
            ),
      ),
    );
  }
}
