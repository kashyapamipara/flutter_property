
import 'dart:convert';

GetAllPropertyModel getAllPropertyModelFromJson(String str) => GetAllPropertyModel.fromJson(json.decode(str));
String getAllPropertyModelToJson(GetAllPropertyModel data) => json.encode(data.toJson());



class GetAllPropertyModel {
  String? successCode;
  int? statusCode;
  String? status;
  List<Data>? data;
  String? message;

  GetAllPropertyModel(
      {this.successCode,
        this.statusCode,
        this.status,
        this.data,
        this.message});

  GetAllPropertyModel.fromJson(Map<String, dynamic> json) {
    successCode = json['successCode'];
    statusCode = json['statusCode'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['successCode'] = this.successCode;
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? createdByName;
  String? sId;
  String? name;
  String? type;
  String? price;
  String? imageURL;
  String? address;
  String? lat;
  String? long;
  String? createdContactNumber;

  Data(
      {this.createdByName,
        this.sId,
        this.name,
        this.type,
        this.price,
        this.imageURL,
        this.address,
        this.lat,
        this.long,
        this.createdContactNumber});

  Data.fromJson(Map<String, dynamic> json) {
    createdByName = json['createdByName'];
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    price = json['price'];
    imageURL = json['imageURL'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    createdContactNumber = json['createdContactNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdByName'] = this.createdByName;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['price'] = this.price;
    data['imageURL'] = this.imageURL;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['createdContactNumber'] = this.createdContactNumber;
    return data;
  }
}
