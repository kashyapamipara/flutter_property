import 'package:flutter/material.dart';
import 'package:flutter_property/app/Screens/register_screen/register_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Constants/app_strings.dart';
import '../../Constants/color.dart';
import '../../Routes/app_pages.dart';
import '../../Widget/button_widget.dart';
import '../../Widget/header_view.dart';
import '../../Widget/switch_widget.dart';
import '../../Widget/text_field_widget.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

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
            child: HeaderView(),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: controller.signUpKey,
              child: Container(
                margin: EdgeInsets.only(
                    top: 10.h, left: 5.w, right: 5.w, bottom: 10.h),
                padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 4.5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.BOTTOM_APP_WHITE_COLOR,
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.SHADOW_LIGHT_COLOR,
                        spreadRadius: 3,
                        blurRadius: 2)
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.createAnAccount,
                      style: TextStyle(
                        color: AppColors.PRIMARY_COLOR,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextFieldWidget(
                      enableTitleText: true,
                      titleText: AppStrings.userName,
                      controller: controller.nameController,
                      hintText: AppStrings.enterYourUserName,
                      hintColor: AppColors.HINT_GREY_COLOR,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        return controller.validateUserName(value!);
                      },
                      maxLength: 50,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 2.h),
                    TextFieldWidget(
                      textFieldKey: controller.emailFieldKey,
                      focusNode: controller.emailFocusNode,
                      autovalidateMode: AutovalidateMode.disabled,
                      enableTitleText: true,
                      titleText: AppStrings.email,
                      controller: controller.emailController,
                      hintText: AppStrings.enterYourEmailAddress,
                      hintColor: AppColors.HINT_GREY_COLOR,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        return controller.validateEmail(value!);
                      },
                      textInputAction: TextInputAction.done,
                      maxLength: 100,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextFieldWidget(
                      textFieldKey: controller.contactNumberKey,
                      focusNode: controller.contactFocusNode,
                      autovalidateMode: AutovalidateMode.disabled,
                      enableTitleText: true,
                      titleText: AppStrings.contactNumber,
                      controller: controller.contactNumberController,
                      hintText: AppStrings.enterYourContactNumber,
                      hintColor: AppColors.HINT_GREY_COLOR,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        return controller.validateMobileNumber(value!);
                      },
                      textInputAction: TextInputAction.done,
                      maxLength: 100,
                    ),
                    SizedBox(height: 2.h),
                    TextFieldWidget(
                      isSuffixIcon: true,
                      enableTitleText: true,
                      maxLines: 1,
                      isDense: true,
                      titleText: AppStrings.password,
                      controller: controller.passwordController,
                      hintText: AppStrings.hintPassword,
                      obscureText: controller.obscureText.value,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        return controller.validatePassword(value!);
                      },
                      visibilityOnPress: (() {
                        controller.obscureText(!controller.obscureText.value);
                      }),
                      maxLength: 30,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SwitchWidget(
                          switchValue: controller.switchValue.value,
                          inactiveColor: AppColors.HINT_GREY_COLOR,
                          width: 7.w,
                          height: 1.8.h,
                          padding: 3,
                          toggleSize: 1.2.h,
                          onPressed: (val) {
                            controller.switchValue.value = val;
                          },
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(AppStrings.registerAsAdmin),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    ButtonWidget(
                      buttonMargin: const EdgeInsets.only(left: 0, right: 0),
                      buttonText: AppStrings.register,
                      onPressed: () {
                        controller.checkSignUp(context);
                      },
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.haveAccount,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.offNamed(Routes.login);
                          },
                          child: Text(
                            AppStrings.login,
                            style: TextStyle(
                              color: AppColors.SECONDARY_COLOR,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
