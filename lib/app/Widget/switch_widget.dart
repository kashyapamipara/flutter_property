import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../Constants/color.dart';

class SwitchWidget extends StatelessWidget {
  bool switchValue;
  Function(bool value)? onPressed;
  Color? activeColor;
  Color? inactiveColor;
  double? width;
  double? height;
  double? toggleSize;
  double? padding;
  Color? activeToggleColor;
  Color? inactiveToggleColor;

  SwitchWidget({
    Key? key,
    required this.switchValue,
    this.onPressed,
    this.activeColor,
    this.inactiveColor,
    this.width,
    this.height,
    this.toggleSize,
    this.padding,
    this.activeToggleColor,
    this.inactiveToggleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      key: key,
      width: width ?? 35.0,
      height: height ?? 17.0,
      toggleSize: toggleSize ?? 15.0,
      value: switchValue,
      borderRadius: 30.0,
      padding: padding ?? 3,
      activeColor: activeColor ?? AppColors.PRIMARY_COLOR,
      inactiveColor: inactiveColor ?? AppColors.GREY_LIGHT_COLOR,
      activeToggleColor: activeToggleColor ?? AppColors.WHITE_COLOR,
      inactiveToggleColor: inactiveToggleColor ?? AppColors.WHITE_COLOR,
      onToggle: (val) {
        onPressed!.call(val);
      },
    );
  }
}
