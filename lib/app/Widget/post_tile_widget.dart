import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../Constants/color.dart';

class PropertyTileWidget extends StatefulWidget {
  final String? personName;
  final bool? isOnRent;
  final String? price;
  final String? contactNumber;
  final String? postCaption;
  final bool isMediaAvailable;
  final String postMediaURLs;
  final String? address;
  final bool isSelected;
  const PropertyTileWidget(
      {Key? key,
      this.personName,
      this.isMediaAvailable = false,
      this.postCaption,
      required this.postMediaURLs,
      this.contactNumber,
      this.isOnRent,
      this.price,
        required this.isSelected,
      this.address})
      : super(key: key);

  @override
  State<PropertyTileWidget> createState() => _PropertyTileWidgetState();
}

class _PropertyTileWidgetState extends State<PropertyTileWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.only(bottom: 1.8.h),
        padding: EdgeInsets.only(bottom: 1.5.h),
        decoration: BoxDecoration(
          color: AppColors.WHITE_COLOR,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: widget.isSelected?AppColors.PRIMARY_COLOR:AppColors.WHITE_COLOR, width: 2)
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 1.3.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(children: [
                            Text(
                              widget.personName ?? 'John Doe',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              widget.contactNumber ?? '881122558',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ]),
                          Column(children: [
                            Text(
                              widget.isOnRent! ? 'Rent' : 'Sell',
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  color: widget.isOnRent!
                                      ? AppColors.PRIMARY_COLOR
                                      : AppColors.RED_COLOR),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              widget.price ?? '20000',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ]),
                        ]),
                  ),
                ]),
          ),
          if (widget.isMediaAvailable) ...[
            SizedBox(
                height: 28.h,
                child: widget.postMediaURLs != 'null'
                    ? Center(
                        child: CachedNetworkImage(
                          imageUrl: widget.postMediaURLs,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const SizedBox()),
          ],
          widget.postCaption != null
              ? Center(
                  child: Text(
                    widget.postCaption ?? '',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : const SizedBox(),
          Text(
            widget.address ?? '',
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.normal,
              color: AppColors.BLACK_COLOR.withOpacity(0.5),
            ),
          ),
        ]));
  }
}
