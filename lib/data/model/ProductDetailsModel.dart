import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) => ProductDetailsModel.fromJson(json.decode(str));


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

}

class ProductDetails {
  String id;
  String name;
  String brand;
  String desc;
  String price;
  String isUsed;
  String? totalView;
  String discountPrice;
  UserId userId;
  CategoryId categoryId;
  CategoryId subCategoryId;
  String img;
  String img2;
  String img3;
  String phone;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  ProductDetails({
    required this.id,
    required this.name,
    required this.brand,
    required this.desc,
    required this.price,
    required this.isUsed,
    required this.totalView,
    required this.discountPrice,
    required this.userId,
    required this.categoryId,
    required this.subCategoryId,
    required this.img,
    required this.img2,
    required this.img3,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
    id: json["_id"],
    name: json["name"],
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
    totalView: json['totalCount'].toString(),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    isUsed: json['isUsed'],
    phone: json['phone'],
  );

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

}
