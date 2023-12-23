import 'dart:convert';

class PropertyModel {
  String? sId;
  String? name;
  String? address;
  String? imageURL;
  String? lat;
  String? long;
  String? type;
  String? price;

  PropertyModel(
      {this.sId,
        this.name,
        this.address,
        this.imageURL,
        this.lat,
        this.long,
        this.type,
        this.price});

  PropertyModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    address = json['address'];
    imageURL = json['imageURL'];
    lat = json['lat'];
    long = json['long'];
    type = json['type'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['imageURL'] = this.imageURL;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['type'] = this.type;
    data['price'] = this.price;
    return data;
  }
}

PropertyModel getAreaDetailsModelFromJson(String str) => PropertyModel.fromJson(json.decode(str));
String getAreaDetailsModelToJson(PropertyModel data) => json.encode(data.toJson());
