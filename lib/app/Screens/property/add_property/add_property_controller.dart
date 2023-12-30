import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_property/app/Constants/api_keys.dart';
import 'package:flutter_property/app/Constants/app_constance.dart';
import 'package:flutter_property/app/Constants/get_storage.dart';
import 'package:flutter_property/app/Network/services/property_service/property_service.dart';
import '../../../Constants/app_strings.dart';
import '../../../Constants/app_utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddPropertyController extends GetxController {
  final GlobalKey<FormState> addPropertyFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController propertyTypeController =
      TextEditingController(text: 'rent');

  RxBool isLoading = false.obs;
  RxString fileUrl = 'null'.obs;
  List<String> propertyType = ['rent', 'sell'];
  File? pickedFile;
  RxBool isFilePicked = false.obs;
  RxBool isFilePicking = false.obs;
  List<Map<String, String>> storagePathUrlList = [];

  @override
  void onInit() async {
    super.onInit();
  }

  String? validatePropertyText(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return AppStrings.pleaseEnterPropertyName;
    }
    return null;
  }

  String? validatePropertyAddress(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return AppStrings.pleaseEnterPropertyName;
    }
    return null;
  }

  String? validatePropertyPrice(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return AppStrings.pleaseEnterPropertyName;
    }else if(!isNumeric(value)){
      return AppStrings.pleaseEnterNumber;
    }
    return null;
  }
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
  Future propertyMediaApi() async {
    if (pickedFile == null) {
      Utils.validationCheck(title: "Error", message: 'Please select file.');
    }
    final firebaseStorage = FirebaseStorage.instance;
    var file = File(pickedFile!.path);
    if (pickedFile != null) {
      //Upload to Firebase
      var snapshot = await firebaseStorage
          .ref()
          .child('images/${DateTime.now()}')
          .putFile(file);
      fileUrl.value = await snapshot.ref.getDownloadURL();
    } else {
      print('No Image Path Received');
    }
  }

  Future addPropertyApi() async {
    final isValid = addPropertyFormKey.currentState!.validate();

    if (!isValid) {
      return;
    } else if (storagePathUrlList.length > 1) {
      Utils.validationCheck(
          title: 'Error', message: 'You can\'t upload more than one media.');
      return;
    } else {
      Map<String, dynamic> params = {
        ApiKeys.name: nameController.text,
        ApiKeys.type: propertyTypeController.text,
        ApiKeys.price: priceController.text,
        ApiKeys.imageURL: fileUrl.value,
        ApiKeys.address: addressController.text,
        ApiKeys.createdByName: getData(AppConstance.name),
        ApiKeys.createdContactNumber: getData(AppConstance.contactNumber),
      };
      await PropertyService().addProperty(params: params);
    }
  }
}
