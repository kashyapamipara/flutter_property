import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants/app_strings.dart';
import '../../Constants/app_validators.dart';
import '../../Network/services/auth_service/auth_service.dart';
import '../../Routes/app_pages.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  GlobalKey<FormFieldState> emailFieldKey = GlobalKey<FormFieldState>();
  GlobalKey<FormFieldState> contactNumberKey = GlobalKey<FormFieldState>();

  FocusNode emailFocusNode = FocusNode();
  FocusNode contactFocusNode = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  Rx<bool> switchValue = false.obs;
  RxBool obscureText = true.obs;

  @override
  void onInit() {
    super.onInit();
    updateEmailFieldState();
  }

  void updateEmailFieldState() {
    emailFocusNode.addListener(() {
      if (!emailFocusNode.hasFocus) {
        emailFieldKey.currentState!.validate();
      }
    });
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterEmailAddress;
    } else if (!AppValidators.emailValidator.hasMatch(value)) {
      return AppStrings.invalidEmail;
    } else if (!AppValidators.emailHeadValidator
        .hasMatch(value.split('@')[0])) {
      return AppStrings.invalidEmail;
    }

    return null;
  }

  String? validateMobileNumber(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterMobileNumber;
    } else if (value.length != 10) {
      return AppStrings.pleaseEnterMobileNumber;
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterPassword;
    }
    return null;
  }

  String? validateUserName(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterName;
    } else if (!AppValidators.nameValidator.hasMatch(value)) {
      return AppStrings.onlyAlphabetsAreAllowedForTheName;
    }
    return null;
  }

  ///sign up api
  void registerApi(context) async {
    var userRegister = await AuthService().registerApiService(
      email: emailController.text,
      name: nameController.text,
      password: passwordController.text,
      contactNumber: contactNumberController.text,
      isAdmin: switchValue.value,
    );
    if (userRegister == 200) {
      Get.offNamed(Routes.login, arguments: Get.arguments);
      emailController.clear();
      nameController.clear();
      signUpKey.currentState!.reset();
      switchValue.value = false;
    }
  }

  ///check sign up
  Future<void> checkSignUp(context) async {
    final isValid = signUpKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      registerApi(context);
    }
  }
}
