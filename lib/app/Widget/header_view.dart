import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../Constants/color.dart';
import '../Constants/images.dart';

class HeaderView extends StatelessWidget {
  bool homeHeader;
  bool showSuffix;
  VoidCallback? suffixIconOnTap;
  VoidCallback? prefixIconOnTap;
  String? tag;
  String headerTitle;
  TextStyle? headerTitleStyle;
  EdgeInsets? padding;
  double? height;
  double? width;
  Image? headerImage;
  Decoration? decoration;
  EdgeInsets? headerImagePadding;
  Widget? headerChild;
  VoidCallback? avatarOnTap;
  double? prefixIconSize;
  Color? headerColor;
  NetworkImage? networkImage;

  HeaderView({
    Key? key,
    this.homeHeader = false,
    this.showSuffix = true,
    this.tag,
    this.headerTitle = "",
    this.headerTitleStyle,
    this.padding,
    this.height,
    this.width,
    this.headerImage,
    this.decoration,
    this.headerImagePadding,
    this.headerChild,
    this.suffixIconOnTap,
    this.prefixIconOnTap,
    this.prefixIconSize = 30,
    this.avatarOnTap,
    this.headerColor,
    this.networkImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return homeHeader
        ? Container(
            width: width ?? MediaQuery.of(context).size.width,
            height: 11.5.h,
            decoration: decoration ??
                BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.PRIMARY_COLOR,
                        blurRadius: 4,
                        spreadRadius: 2)
                  ],
                  color: headerColor ?? AppColors.PRIMARY_COLOR,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
            child: Container(
              margin: EdgeInsets.only(left: 5.w, right: 5.w, top: 3.5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (prefixIconOnTap != null)
                    Row(
                      children: [
                        InkWell(
                          onTap: prefixIconOnTap,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: 12.w,
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColors.WHITE_COLOR,
                              size: prefixIconSize,
                            ),
                          ),
                        ),
                        // SizedBox(width: 3.w),
                        Text(
                          headerTitle,
                          style: headerTitleStyle ??
                              TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                        ),
                      ],
                    )
                  else
                    Text(
                      headerTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: textScaleFactor * 20,
                      ),
                    ),
                  if (showSuffix)
                    Row(
                      children: [
                        InkWell(
                          onTap: suffixIconOnTap,
                          child: Icon(
                            Icons.pin_drop,
                            color: AppColors.WHITE_COLOR,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        InkWell(
                          onTap: avatarOnTap,
                          child: CircleAvatar(
                            radius: 5.w,
                            backgroundColor: AppColors.SECONDARY_COLOR,
                            foregroundImage: networkImage ??
                                const NetworkImage(
                                    'https://picsum.photos/id/237/200/300'),
                          ),
                        )
                      ],
                    )
                ],
              ),
            ),
          )
        : Hero(
            tag: tag ?? 'heroTag',
            child: Container(
              width: width ?? MediaQuery.of(context).size.width,
              decoration: decoration ??
                  BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.PRIMARY_COLOR,
                          blurRadius: 4,
                          spreadRadius: 2)
                    ],
                    color: AppColors.PRIMARY_COLOR,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
              constraints: BoxConstraints(
                maxHeight: height != null ? height! + 20 : 11.5.h,
              ),
              child: Column(
                mainAxisSize:
                    headerChild != null ? MainAxisSize.min : MainAxisSize.max,
                children: [
                  Padding(
                    padding: headerImagePadding ??
                        EdgeInsets.only(top: 4.2.h, bottom: 1.h, left: 2.w),
                    child: headerImage ??
                        SvgPicture.asset(Images.splashLogo, height: 6.h),
                  ),
                  headerChild ?? const SizedBox(),
                ],
              ),
            ),
          );
  }
}
