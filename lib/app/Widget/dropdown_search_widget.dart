import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:sizer/sizer.dart';
import '../Constants/color.dart';

class DropdownSearchWidget<T> extends StatelessWidget {
  List<T> items;
  String? titleText;
  T? selectedItem;
  String? hintText;
  TextStyle? selectedItemTextStyle;
  List<String>? unSelectableItems;
  TextStyle? disableTextStyle;
  String? searchHintText;
  ValueChanged<T?>? onChanged;
  String? errorText;
  VoidCallback? dropDownOnTap;
  AutovalidateMode? autoValidateMode;
  bool enabled;
  FlexFit? flexFit;
  Widget Function(BuildContext context, T item, bool isSelected)? itemBuilder;
  Widget Function(BuildContext context, T? selectedItem)? dropdownBuilder;
  bool? unableTitleText;
  Widget? dropdownButtonIcon;
  double? borderRadius;
  bool showSearchBox;
  EdgeInsetsGeometry? contentPadding;

  ///If true then picked country item display without countryCode
  BoxConstraints? boxConstraints;
  bool isValidate;
  FormFieldValidator<T?>? validator;

  DropdownSearchWidget({
    Key? key,
    required this.items,
    this.titleText,
    this.selectedItem,
    this.hintText,
    this.searchHintText,
    this.onChanged,
    this.unSelectableItems,
    this.errorText,
    this.enabled = true,
    this.dropDownOnTap,
    this.selectedItemTextStyle,
    this.autoValidateMode,
    this.itemBuilder,
    this.dropdownBuilder,
    this.unableTitleText = true,
    this.dropdownButtonIcon,
    this.borderRadius,
    this.showSearchBox = true,
    this.flexFit = FlexFit.loose,
    this.contentPadding,
    this.boxConstraints,
    this.isValidate = true,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (unableTitleText!) ...[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              titleText ?? '',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.BLACK_COLOR,
              ),
            ),
          ),
          SizedBox(height: 0.6.h),
        ],
        InkWell(
          onTap: dropDownOnTap,
          child: IgnorePointer(
            ignoring: !enabled,
            child: DropdownSearch<T>(
              key: key,
              autoValidateMode:
                  autoValidateMode ?? AutovalidateMode.onUserInteraction,
              validator: isValidate
                  ? (validator ??
                      (value) {
                        if (hintText != null) {
                          if (value == hintText) {
                            return errorText;
                          } else if (value == 'Select Type') {
                            return errorText;
                          }
                          return null;
                        } else {
                          if (value == selectedItem) {
                            return errorText;
                          }
                          return null;
                        }
                      })
                  : (value) {
                      return null;
                    },
              selectedItem: selectedItem,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: AppColors.WHITE_COLOR,
                  hintText: hintText,
                  isDense: true,
                  constraints: boxConstraints,
                  suffixIconConstraints: BoxConstraints(),
                  contentPadding: contentPadding ??
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.6.h),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: AppColors.GREY_LIGHT_COLOR),
                    borderRadius: BorderRadius.circular(borderRadius ?? 12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: AppColors.GREY_LIGHT_COLOR),
                    borderRadius: BorderRadius.circular(borderRadius ?? 12),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: AppColors.GREY_LIGHT_COLOR),
                    borderRadius: BorderRadius.circular(borderRadius ?? 12),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: AppColors.RED_COLOR),
                    borderRadius: BorderRadius.circular(borderRadius ?? 12),
                  ),
                  errorStyle: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              dropdownBuilder: dropdownBuilder ??
                  (context, selectedItem) {
                    if (selectedItem == null) {
                      return Text(
                        selectedItem as String ?? '',
                        style: TextStyle(
                            color: AppColors.HINT_GREY_COLOR, fontSize: 20.sp),
                        overflow: TextOverflow.ellipsis,
                      );
                    } else {
                      if (!items.contains(selectedItem)) {
                        return Text(
                          selectedItem as String ?? '',
                          style: TextStyle(
                              color: AppColors.HINT_GREY_COLOR,
                              overflow: TextOverflow.ellipsis),
                        );
                      } else {
                        return Text(selectedItem.toString(),
                            overflow: TextOverflow.ellipsis);
                      }
                    }
                  },
              popupProps: PopupProps.menu(
                showSearchBox: showSearchBox,
                fit: flexFit ?? FlexFit.tight,
                containerBuilder: flexFit == FlexFit.loose
                    ? (context, popupWidget) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 3.w),
                          child: popupWidget,
                        );
                      }
                    : null,
                searchFieldProps: TextFieldProps(
                  cursorColor: AppColors.SECONDARY_COLOR,
                  decoration: InputDecoration(
                    hintText: searchHintText ?? '',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: AppColors.PRIMARY_COLOR)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(width: 1, color: AppColors.PRIMARY_COLOR),
                    ),
                    contentPadding: contentPadding ??
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
                  ),
                ),
                itemBuilder: itemBuilder ??
                    (context, item, isSelected) {
                      return Text(
                        item.toString(),
                      ).marginOnly(
                        left: 20,
                        top: 12,
                        bottom: 12,
                        right: 20,
                      );
                    },
              ),
              onBeforeChange: (prevItem, nextItem) async {
                if (unSelectableItems != null) {
                  if (unSelectableItems!.contains(nextItem)) {
                    return false;
                  }
                }
                return true;
              },
              dropdownButtonProps: DropdownButtonProps(
                constraints: BoxConstraints(),
                color: AppColors.GREY_LIGHT_COLOR,
                focusColor: AppColors.PRIMARY_COLOR,
                icon: dropdownButtonIcon ??
                    const Icon(Icons.arrow_drop_down, size: 24),
              ),
              items: items,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
