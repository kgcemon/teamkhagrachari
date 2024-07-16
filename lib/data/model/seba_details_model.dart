class SebaDetailsModel {
  int? statusCode;
  bool? success;
  String? message;
  SebaData? data;

  SebaDetailsModel({this.statusCode, this.success, this.message, this.data});

  SebaDetailsModel.fromJson(Map json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? SebaData.fromJson(json['data']) : null;
  }
}

class SebaData {
  Meta? meta;
  List<SebaDetailsDataListModel>? data;

  SebaData({this.meta, this.data});

  SebaData.fromJson(Map json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <SebaDetailsDataListModel>[];
      json['data'].forEach((v) {
        data!.add(SebaDetailsDataListModel.fromJson(v));
      });
    }
  }
}

class Meta {
  int? page;
  int? limit;
  int? total;

  Meta({this.page, this.limit, this.total});

  Meta.fromJson(Map json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['page'] = page;
    data['limit'] = limit;
    data['total'] = total;
    return data;
  }
}

class SebaDetailsDataListModel {
  String? sId;
  String? name;
  String? description;
  String? addressDegree;
  String? phone;
  String? email;
  String? serviceProviderName;
  String? location;
  ServicesCategory? servicesCategory;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? status;

  SebaDetailsDataListModel(
      {this.sId,
        this.name,
        this.addressDegree,
        this.description,
        this.phone,
        this.email,
        this.serviceProviderName,
        this.location,
        this.servicesCategory,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.iV});

  SebaDetailsDataListModel.fromJson(Map json) {
    sId = json['_id'];
    name = json['name'];
    status = json['status'];
    addressDegree = json['addressDegree'];
    description = json['description'];
    phone = json['phone'];
    email = json['email'];
    serviceProviderName = json['serviceProviderName'];
    location = json['location'];
    servicesCategory = json['servicesCategory'] != null
        ? ServicesCategory.fromJson(json['servicesCategory'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

class ServicesCategory {
  String? sId;
  String? name;
  String? img;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ServicesCategory(
      {this.sId,
        this.name,
        this.img,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.iV});

  ServicesCategory.fromJson(Map json) {
    sId = json['_id'];
    name = json['name'];
    img = json['img'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
