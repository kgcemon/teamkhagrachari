import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) => ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) => json.encode(data.toJson());

class ProductDetailsModel {
  int statusCode;
  bool success;
  String message;
  ProductData data;

  ProductDetailsModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProductDetailsModel.fromJson(Map json) => ProductDetailsModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    data: ProductData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class ProductData {
  Meta meta;
  List<ProductDetails> data;

  ProductData({
    required this.meta,
    required this.data,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
    meta: Meta.fromJson(json["meta"]),
    data: List<ProductDetails>.from(json["data"].map((x) => ProductDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ProductDetails {
  String id;
  String name;
  String title;
  String brand;
  String desc;
  String price;
  String discountPrice;
  UserId userId;
  CategoryId categoryId;
  CategoryId subCategoryId;
  String img;
  String img2;
  String img3;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  ProductDetails({
    required this.id,
    required this.name,
    required this.title,
    required this.brand,
    required this.desc,
    required this.price,
    required this.discountPrice,
    required this.userId,
    required this.categoryId,
    required this.subCategoryId,
    required this.img,
    required this.img2,
    required this.img3,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
    id: json["_id"],
    name: json["name"],
    title: json["title"],
    brand: json["brand"],
    desc: json["desc"],
    price: json["price"],
    discountPrice: json["discountPrice"],
    userId: UserId.fromJson(json["userId"]),
    categoryId: CategoryId.fromJson(json["categoryId"]),
    subCategoryId: CategoryId.fromJson(json["subCategoryId"]),
    img: json["img"],
    img2: json["img2"],
    img3: json["img3"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "title": title,
    "brand": brand,
    "desc": desc,
    "price": price,
    "discountPrice": discountPrice,
    "userId": userId.toJson(),
    "categoryId": categoryId.toJson(),
    "subCategoryId": subCategoryId.toJson(),
    "img": img,
    "img2": img2,
    "img3": img3,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class CategoryId {
  String id;
  String name;
  String? icon;
  String description;
  bool status;
  int? serialNo;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String? category;

  CategoryId({
    required this.id,
    required this.name,
    this.icon,
    required this.description,
    required this.status,
    this.serialNo,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.category,
  });

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
    id: json["_id"],
    name: json["name"],
    icon: json["icon"],
    description: json["description"],
    status: json["status"],
    serialNo: json["serialNo"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "icon": icon,
    "description": description,
    "status": status,
    "serialNo": serialNo,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "category": category,
  };
}

class UserId {
  bool isDonor;
  String id;
  String email;
  String name;
  String phone;
  String upazila;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  UserId({
    required this.isDonor,
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.upazila,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    isDonor: json["isDonor"],
    id: json["_id"],
    email: json["email"],
    name: json["name"],
    phone: json["phone"],
    upazila: json["upazila"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "isDonor": isDonor,
    "_id": id,
    "email": email,
    "name": name,
    "phone": phone,
    "upazila": upazila,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class Meta {
  int page;
  int limit;
  int total;

  Meta({
    required this.page,
    required this.limit,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    page: json["page"],
    limit: json["limit"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
  };
}
