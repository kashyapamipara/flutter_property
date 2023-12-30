import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../Constants/app_strings.dart';
import '../../Constants/color.dart';
import '../../Routes/app_pages.dart';
import '../../Widget/button_widget.dart';
import '../../Widget/header_view.dart';
import '../../Widget/text_field_widget.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  LoginController controller = Get.put(LoginController());

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
              key: controller.loginKey,
              child: Container(
                margin: EdgeInsets.only(top: 10.h, left: 5.w, right: 5.w, bottom: 10.h),
                padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 4.5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.BOTTOM_APP_WHITE_COLOR,
                  boxShadow: [BoxShadow(color: AppColors.SHADOW_LIGHT_COLOR, spreadRadius: 3, blurRadius: 2)],
                ),
                width: 100.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.login,
                      style: TextStyle(
                        color: AppColors.PRIMARY_COLOR,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Text(
                        textAlign: TextAlign.center,
                        AppStrings.enterYourCredentials,
                        style: TextStyle(
                          color: AppColors.BLACK_COLOR,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),

                    ///Email
                    TextFieldWidget(
                      enableTitleText: true,
                      titleText: AppStrings.email,
                      controller: controller.emailController,
                      hintText: AppStrings.enterYourEmail,
                      hintColor: AppColors.HINT_GREY_COLOR,
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.disabled,
                      validator: (value) {
                        return controller.validateEmail(value!.trim());
                      },
                    ),
                    SizedBox(height: 2.h),

                    ///Password
                    TextFieldWidget(
                      isSuffixIcon: true,
                      enableTitleText: true,
                      maxLines: 1,
                      titleText: AppStrings.password,
                      controller: controller.passwordController,
                      hintText: AppStrings.enterYourPassword,
                      hintColor: AppColors.HINT_GREY_COLOR,
                      obscureText: controller.obscureText.value,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        return controller.validatePassword(value!);
                      },
                      visibilityOnPress: (() {
                        controller.obscureText(!controller.obscureText.value);
                      }),
                    ),
                    SizedBox(height: 2.h),

                    ButtonWidget(
                      buttonMargin: const EdgeInsets.only(left: 0, right: 0),
                      buttonText: AppStrings.login,
                      onPressed: () {
                        controller.checkLogin();
                      },
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.noAccount,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.offNamed(Routes.register);
                          },
                          child: Text(
                            AppStrings.register,
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
