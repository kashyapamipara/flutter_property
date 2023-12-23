import 'package:flutter_property/app/Network/Models/property_model.dart';
import 'package:flutter_property/app/Network/services/property_service/property_service.dart';
import 'package:get/get.dart';

class PropertyController extends GetxController {
  Rx<List<PropertyModel>> properties = Rx<List<PropertyModel>>([]);
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    isLoading.value = true;
    getAllProperty();
    isLoading.value = false;

    super.onInit();
  }

  Future<void> getAllProperty() async {
    properties.value = await PropertyService().getAllPropertyValuesApiService();
  }
}
