class UserProfileSebaModel {
  int? statusCode;
  bool? success;
  String? message;
  List<Data>? data;

  UserProfileSebaModel(
      {this.statusCode, this.success, this.message, this.data});

  UserProfileSebaModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

}

class Data {
  String? sId;
  String? name;
  String? view;
  String? description;
  String? phone;
  String? email;
  String? addressDegree;
  String? serviceProviderName;
  String? location;
  ServicesCatagory? servicesCatagory;
  bool? status;
  bool? premium;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
        this.name,
        this.view,
        this.description,
        this.phone,
        this.email,
        this.addressDegree,
        this.serviceProviderName,
        this.location,
        this.servicesCatagory,
        this.status,
        this.premium,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    view = json['totalCount'].toString();
    description = json['description'];
    phone = json['phone'];
    email = json['email'];
    addressDegree = json['addressDegree'];
    serviceProviderName = json['serviceProviderName'];
    location = json['location'];
    servicesCatagory = json['servicesCatagory'] != null
        ? ServicesCatagory.fromJson(json['servicesCatagory'])
        : null;
    status = json['status'];
    premium = json['premium'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

class ServicesCatagory {
  String? sId;
  String? name;
  String? img;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? serialNo;

  ServicesCatagory(
      {this.sId,
        this.name,
        this.img,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.serialNo});

  ServicesCatagory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    img = json['img'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    serialNo = json['serialNo'];
  }
}
