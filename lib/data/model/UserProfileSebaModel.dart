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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? name;
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
    description = json['description'];
    phone = json['phone'];
    email = json['email'];
    addressDegree = json['addressDegree'];
    serviceProviderName = json['serviceProviderName'];
    location = json['location'];
    servicesCatagory = json['servicesCatagory'] != null
        ? new ServicesCatagory.fromJson(json['servicesCatagory'])
        : null;
    status = json['status'];
    premium = json['premium'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['addressDegree'] = this.addressDegree;
    data['serviceProviderName'] = this.serviceProviderName;
    data['location'] = this.location;
    if (this.servicesCatagory != null) {
      data['servicesCatagory'] = this.servicesCatagory!.toJson();
    }
    data['status'] = this.status;
    data['premium'] = this.premium;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['img'] = this.img;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['serialNo'] = this.serialNo;
    return data;
  }
}
