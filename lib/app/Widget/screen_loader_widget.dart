import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Constants/color.dart';

class ScreenLoaderWidget extends StatelessWidget {
  final bool showLoader;
  final Widget child;
  final double? height;

  const ScreenLoaderWidget({
    Key? key,
    required this.child,
    required this.showLoader,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: SizedBox(
        height: height ?? 80.h,
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.PRIMARY_COLOR,
          ),
        ),
      ),
      secondChild: child,
      crossFadeState: showLoader ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 550),
    );
  }
}
