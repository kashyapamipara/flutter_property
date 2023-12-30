import 'package:flutter/material.dart';
import 'package:flutter_property/app/Network/services/auth_service/auth_service.dart';
import 'package:flutter_property/app/Network/services/property_service/property_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constants/app_strings.dart';
import '../../Network/Models/get_all_property_model.dart';

class PropertyController extends GetxController {
  Rx<GetAllPropertyModel> properties = GetAllPropertyModel().obs;
  TextEditingController searchController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String? searchedProperty;
  RxBool isFiltered = false.obs;
  RxString selectedItemProperty = AppStrings.selectProperty.obs;
  List<String?> propertyFilterList = ['rent', 'sell'];
  int? selectedPropertyID = -1;
  RxList<int> selectedProperty = <int>[].obs;

  RxBool isLoading = false.obs;
  @override
  void onInit() {
    isLoading.value = true;
    getAllProperty();
    isLoading.value = false;

    super.onInit();
  }

  Future<void> getAllProperty() async {
    isLoading.value = true;
    selectedPropertyID = -1;

    properties.value = await PropertyService().getAllPropertyValuesApiService(
        type: selectedItemProperty.value == AppStrings.selectProperty
            ? null
            : selectedItemProperty.value,
        price: priceController.text,
        search: searchedProperty);
    isLoading.value = false;
  }

  void getDistance(
    String? originAddresss,
    String? destinationAddress,
  ) async {
    String url =
        'https://www.google.com/maps/dir/?api=1&origin=$originAddresss&destination=$destinationAddress&travelmode=driving&dir_action=navigate';
    print('^^^^$url');
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void resetDataEvent() {
    selectedItemProperty.value = AppStrings.selectProperty;
    priceController.clear();
    isFiltered(false);
  }

  Future<void> logout() async {
    await AuthService().logoutApi();
  }
}
