import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../Constants/api_keys.dart';
import '../../../Constants/api_urls.dart';
import '../../../Constants/app_constance.dart';
import '../../../Constants/app_utils.dart';
import '../../../Constants/get_storage.dart';
import '../../../Routes/app_pages.dart';
import '../../Models/login_model.dart';
import '../../ResponseModel.dart';
import '../../api_base_helper.dart';

class AuthService {
  Future<int?> registerApiService({
    required String email,
    required String name,
    required String password,
    required String contactNumber,
    required bool isAdmin,
  }) async {
    var param = {
      ApiKeys.email: email,
      ApiKeys.name: name,
      ApiKeys.password: password,
      ApiKeys.contactNumber: contactNumber,
      ApiKeys.role: isAdmin ? "admin" : "user",
    };
    var response = await ApiBaseHelper().postHTTP(
      ApiUrls.signUpApi,
      showProgress: true,
      onError: (error) {
        Utils.validationCheck(message: error.message);
      },
      onSuccess: (res) {
        if (res.statusCode! >= 200 && res.statusCode! <= 299) {
          Utils.validationCheck(message: res.message, title: 'Success');
          Get.offNamed(Routes.login, arguments: Get.arguments);
        } else {
          Utils.validationCheck(
              message: 'Something went wrong or email already exists.');
        }
      },
      params: param,
    );

    return response.statusCode;
  }

  Future<ResponseModel?> loginApiService({
    required String email,
    required String password,
  }) async {
    var param = {
      ApiKeys.email: email,
      ApiKeys.password: password,
    };
    var response = await ApiBaseHelper().postHTTP(
      ApiUrls.loginApi,
      showProgress: true,
      onError: (error) {
        Utils.validationCheck(message: error.message);
      },
      onSuccess: (res) {
        LoginModel loginModel = loginModelFromJson(res.response.toString());
        if (res.statusCode! >= 200 && res.statusCode! <= 299) {
          setData(AppConstance.authorizationToken, loginModel.data!.token);
          setData(AppConstance.role, loginModel.data!.role);
          setData(AppConstance.email, loginModel.data!.email);
          setData(AppConstance.name, loginModel.data!.name);
          setData(AppConstance.contactNumber, loginModel.data!.contactNumber);
          Get.offAllNamed(Routes.property);
        } else {
          Utils.validationCheck(message: loginModel.message);
        }
      },
      params: param,
    );
    return response;
  }

  Future<ResponseModel?> logoutApi() async {
    var response = await ApiBaseHelper().postHTTP(
      ApiUrls.logoutApi,
      showProgress: true,
      onError: (error) {
        Utils.validationCheck(message: error.message);
      },
      onSuccess: (res) {
        if (res.statusCode! >= 200 && res.statusCode! <= 299) {
          clearData();
          Get.offAllNamed(Routes.login);
        } else {
          Utils.validationCheck(
              message: res.message ?? 'Something Went Wrong!');
        }
      },
    );
    return response;
  }
}
