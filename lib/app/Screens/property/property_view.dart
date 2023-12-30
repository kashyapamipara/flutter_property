import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_property/app/Constants/app_constance.dart';
import 'package:flutter_property/app/Constants/app_utils.dart';
import 'package:flutter_property/app/Constants/get_storage.dart';
import 'package:flutter_property/app/Screens/property/property_controller.dart';
import 'package:flutter_property/app/Widget/post_tile_widget.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Constants/app_strings.dart';
import '../../Constants/color.dart';
import '../../Routes/app_pages.dart';
import '../../Widget/button_widget.dart';
import '../../Widget/dropdown_search_widget.dart';
import '../../Widget/header_view.dart';
import '../../Widget/text_field_widget.dart';

class PropertyView extends GetView<PropertyController> {
  const PropertyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColors.BACKGROUND_COLOR,
          appBar: PreferredSize(
            preferredSize: Size(100.w, 11.5.h),
            child: HeaderView(
              suffixIconOnTap: () {
                controller.logout();
              },
              homeHeader: true,
              headerTitle: AppStrings.property,
            ),
          ),
          bottomSheet: controller.selectedProperty.length == 2
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 10.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.WHITE_COLOR,
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.SHADOW_BUTTON_COLOR,
                              spreadRadius: 2,
                              blurRadius: 1)
                        ],
                      ),
                      child: ButtonWidget(
                        buttonText: AppStrings.findDistance,
                        onPressed: () async {
                          controller.getDistance(
                              controller.properties.value
                                  .data![controller.selectedProperty[0]].address,
                              controller.properties.value
                                  .data![controller.selectedProperty[1]].address,);
                        },
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
          body: controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                  color: AppColors.PRIMARY_COLOR,
                ))
              : Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 2.h, left: 4.w, right: 4.w),
                      color: AppColors.BACKGROUND_COLOR,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFieldWidget(
                                    controller: controller.searchController,
                                    hintText: AppStrings.search,
                                    textFieldWidth: 53.w,
                                    onChanged: (value) {
                                      if (value == '') {
                                        controller.searchedProperty = null;
                                        controller.getAllProperty();
                                      }
                                    },
                                    onFieldSubmitted: (value) {
                                      if (value == '') {
                                        controller.searchedProperty = null;
                                      } else {
                                        controller.searchedProperty = value;
                                      }
                                      controller.getAllProperty();
                                    },
                                    textInputAction: TextInputAction.search,
                                  ),
                                  SizedBox(width: 2.w),
                                  InkWell(
                                    onTap: () {
                                      if (controller
                                          .searchController.text.isNotEmpty) {
                                        controller.searchedProperty =
                                            controller.searchController.text;
                                      }
                                      getBottomSheet(controller);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.PRIMARY_COLOR,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(9),
                                            child: Icon(
                                                Icons.filter_list_outlined,
                                                color: AppColors.WHITE_COLOR,
                                                size: 3.2.h),
                                          ),
                                          if (controller.isFiltered.value)
                                            Container(
                                              width: 2.w,
                                              height: 2.w,
                                              margin: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  color:
                                                      AppColors.SECONDARY_COLOR,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          99)),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (getData(AppConstance.role) == 'admin')
                                Expanded(
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(Routes.addProperty);
                                            if (controller.searchController.text
                                                .isNotEmpty) {
                                              controller.searchController
                                                  .clear();
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(9),
                                            decoration: BoxDecoration(
                                                color: AppColors.PRIMARY_COLOR,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Icon(Icons.add,
                                                color: AppColors.WHITE_COLOR,
                                                size: 3.2.h),
                                          ),
                                        ),
                                      ]),
                                ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                    controller.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.PRIMARY_COLOR,
                            ),
                          )
                        : Expanded(
                            child: Obx(() {
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 3.w),
                                    child: InkWell(
                                      onTap: () {
                                        if (controller.selectedProperty
                                            .contains(index)) {
                                          controller.selectedProperty
                                              .removeWhere((element) =>
                                                  element == index);
                                        } else {
                                          if (controller
                                                  .selectedProperty.length ==
                                              2) {
                                            Utils.validationCheck(
                                                title: 'Error',
                                                message:
                                                    'You can only select two items');
                                          } else {
                                            controller.selectedProperty
                                                .add(index);
                                          }
                                        }
                                      },
                                      child: Obx(() {
                                        return PropertyTileWidget(
                                          isSelected: controller
                                              .selectedProperty
                                              .contains(index),
                                          address: controller.properties.value
                                              .data?[index].address,
                                          contactNumber: controller
                                              .properties
                                              .value
                                              .data?[index]
                                              .createdContactNumber,
                                          isOnRent: controller.properties.value
                                                      .data?[index].type ==
                                                  'rent'
                                              ? true
                                              : false,
                                          price: controller.properties.value
                                              .data?[index].price,
                                          postMediaURLs: controller
                                                  .properties
                                                  .value
                                                  .data?[index]
                                                  .imageURL ??
                                              'https://fastly.picsum.photos/id/866/200/300.jpg',
                                          personName: controller.properties
                                              .value.data![index].createdByName,
                                          postCaption: controller.properties
                                              .value.data![index].name,
                                          isMediaAvailable: controller
                                                      .properties
                                                      .value
                                                      .data?[index]
                                                      .imageURL !=
                                                  'null'
                                              ? true
                                              : false,
                                        );
                                      }),
                                    ),
                                  );
                                },
                                itemCount:
                                    controller.properties.value.data?.length ??
                                        0,
                              );
                            }),
                          ),
                  ],
                ),
        ),
      );
    });
  }

  getBottomSheet(PropertyController controller) {
    Get.bottomSheet(
      Obx(() {
        return Padding(
          padding: EdgeInsets.only(bottom: 2.h),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.GREY_LIGHT_COLOR,
                    borderRadius: BorderRadius.circular(12)),
                width: 16.w,
                height: 5,
                margin: EdgeInsets.only(top: 2.h),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 5.h, left: 5.w, right: 5.w, bottom: 1.8.h),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DropdownSearchWidget(
                        items: controller.propertyFilterList.map((element) {
                          return element;
                        }).toList(),
                        titleText: AppStrings.selectProperty,
                        selectedItem: controller.selectedItemProperty.value,
                        searchHintText: AppStrings.search,
                        onChanged: (value) {
                          controller.selectedItemProperty.value = value!;
                          if (value == 'rent') {
                            controller.selectedPropertyID = 0;
                          } else {
                            controller.selectedPropertyID = 1;
                          }
                        },
                      ),
                      SizedBox(height: 2.h),
                      TextFieldWidget(
                        controller: controller.priceController,
                        enableTitleText: true,
                        titleText: AppStrings.propertyPrice,
                        hintText: AppStrings.propertyPrice,
                        minLines: 1,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 1.h),

                      ///Reset & Apply
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonWidget(
                            buttonText: AppStrings.reset,
                            onPressed: () {
                              controller.resetDataEvent();
                              controller.getAllProperty();
                              Get.back();
                            },
                            buttonWidth: 43.w,
                            buttonMargin: EdgeInsets.zero,
                            borderRadius: BorderRadius.circular(8),
                            buttonBorderSide: BorderSide.none,
                            buttonTextStyle: TextStyle(
                              color: AppColors.WHITE_COLOR,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            buttonColor: AppColors.SECONDARY_COLOR,
                          ),
                          SizedBox(width: 4.w),
                          ButtonWidget(
                            buttonText: AppStrings.apply,
                            onPressed: () {
                              if (controller.selectedPropertyID != null) {
                                controller.isFiltered(true);
                              }
                              controller.getAllProperty();
                              Get.back();
                            },
                            buttonWidth: 43.w,
                            buttonMargin: EdgeInsets.zero,
                            borderRadius: BorderRadius.circular(8),
                            buttonBorderSide: BorderSide.none,
                            buttonTextStyle: TextStyle(
                              color: AppColors.WHITE_COLOR,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            buttonColor: AppColors.PRIMARY_COLOR,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(32)),
      ),
      backgroundColor: AppColors.WHITE_COLOR,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 300),
    );
  }
}
