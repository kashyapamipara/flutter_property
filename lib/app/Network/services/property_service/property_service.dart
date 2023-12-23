import 'package:flutter/material.dart';

import '../../../Constants/api_urls.dart';
import '../../../Constants/app_utils.dart';
import '../../Models/property_model.dart';
import '../../api_base_helper.dart';

class PropertyService {
  Future<List<PropertyModel>> getAllPropertyValuesApiService() async {
    List<PropertyModel> properties=[];
    var response = await ApiBaseHelper().getHTTP(
      ApiUrls.getAllProperty,
      onError: (dioExceptions) {
        Utils.validationCheck(message: dioExceptions.message);
      },
      onSuccess: (res) {
        if (res.statusCode! >= 200 && res.statusCode! <= 299) {
          print('********${res.response?.data}');
          properties = res.response?.data;
          print('getAllData success :::: ${res.response!.data['message']}');
        } else {
          print('getAllData error :::: ${res.response!.data['message']}');
        }
      },
      showProgress: false,
    );
    return properties;
  }
}
