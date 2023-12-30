import 'package:flutter_property/app/Constants/api_keys.dart';
import 'package:flutter_property/app/Screens/property/property_controller.dart';
import 'package:get/get.dart';
import '../../../Constants/api_urls.dart';
import '../../../Constants/app_utils.dart';
import '../../Models/get_all_property_model.dart';
import '../../api_base_helper.dart';

class PropertyService {
  Future<GetAllPropertyModel> getAllPropertyValuesApiService(
      {String? search, String? type, String? price}) async {
    var response = await ApiBaseHelper().getHTTP(
      ApiUrls.getAllProperty,
      params: {
        ApiKeys.search: (search != null && search.isNotEmpty) ? search : '',
        ApiKeys.type: (type != null && type.isNotEmpty) ? type : '',
        ApiKeys.price: (price != null && price.isNotEmpty) ? price : ''
      },
      onError: (dioExceptions) {
        Utils.validationCheck(message: dioExceptions.message);
      },
      onSuccess: (res) {
        if (res.statusCode! >= 200 && res.statusCode! <= 299) {
          Utils.validationCheck(
              title: 'Success',
              message: res.message ?? 'Something Went Wrong!');
        } else {
          Utils.validationCheck(
              message: res.message ?? 'Something Went Wrong!');
        }
      },
      showProgress: false,
    );
    return getAllPropertyModelFromJson(response.response.toString());
  }

  Future<void> addProperty({params}) async {
    var response = await ApiBaseHelper().postHTTP(
      ApiUrls.addProperty,
      params: params,
      onError: (dioExceptions) {
        Utils.validationCheck(message: dioExceptions.message);
      },
      onSuccess: (res) {
        if (res.statusCode! >= 200 && res.statusCode! <= 299) {
          Get.find<PropertyController>().getAllProperty();
          Get.back();
          Utils.validationCheck(
              title: 'Success',
              message: res.message ?? 'Something Went Wrong!');
        } else {
          Utils.validationCheck(message: 'Please enter valid address!');
        }
      },
      showProgress: false,
    );
  }
}
