import 'package:flutter/material.dart';
import 'package:flutter_property/app/Routes/app_pages.dart';
import 'package:get/get.dart';

import '../../Constants/app_constance.dart';
import '../../Constants/app_strings.dart';
import '../../Constants/app_validators.dart';
import '../../Network/services/auth_service/auth_service.dart';


class LoginController extends GetxController {
  RxBool obscureText = true.obs;

  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Rx<bool> switchValue = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    Future.delayed(
      const Duration(seconds: 4),
      () async {
      },
    );
    super.onInit();
  }

  /// user login api
  void loginApi() async {
     await AuthService().loginApiService(
      email: emailController.text,
      password: passwordController.text,
    );
  }

  /// validate email
  String? validateEmail(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterEmailAddress;
    }else if (!AppValidators.emailValidator.hasMatch(value)) {
      return AppStrings.invalidEmail;
    }
    return null;
  }

  /// validate password
  String? validatePassword(String value) {
    if (value.isEmpty) {
      return AppStrings.pleaseEnterPassword;
    }
    return null;
  }

  /// check login
  Future<void> checkLogin() async {
    final isValid = loginKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      loginApi();
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.clear();
    passwordController.clear();
  }
}
