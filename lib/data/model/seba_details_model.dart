class SebaDetailsModel {
  int? statusCode;
  bool? success;
  String? message;
  SebaData? data;

  SebaDetailsModel({this.statusCode, this.success, this.message, this.data});

  SebaDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? SebaData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SebaData {
  Meta? meta;
  List<SebaDetailsDataListModel>? data;

  SebaData({this.meta, this.data});

  SebaData.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <SebaDetailsDataListModel>[];
      json['data'].forEach((v) {
        data!.add(SebaDetailsDataListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  int? page;
  int? limit;
  int? total;

  Meta({this.page, this.limit, this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  String? phone;
  String? email;
  String? serviceProviderName;
  String? location;
  ServicesCategory? servicesCategory;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SebaDetailsDataListModel(
      {this.sId,
        this.name,
        this.description,
        this.phone,
        this.email,
        this.serviceProviderName,
        this.location,
        this.servicesCategory,
        this.createdAt,
        this.updatedAt,
        this.iV});

  SebaDetailsDataListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['phone'] = phone;
    data['email'] = email;
    data['serviceProviderName'] = serviceProviderName;
    data['location'] = location;
    if (servicesCategory != null) {
      data['servicesCategory'] = servicesCategory!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
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

  ServicesCategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    img = json['img'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['img'] = img;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
