// To parse this JSON data, do
//
//     final buySellCategoryModel = buySellCategoryModelFromJson(jsonString);

import 'dart:convert';

BuySellCategoryModel buySellCategoryModelFromJson(String str) => BuySellCategoryModel.fromJson(json.decode(str));

String buySellCategoryModelToJson(BuySellCategoryModel data) => json.encode(data.toJson());

class BuySellCategoryModel {
  int statusCode;
  bool success;
  String message;
  Data data;

  BuySellCategoryModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory BuySellCategoryModel.fromJson(Map<String, dynamic> json) => BuySellCategoryModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Meta meta;
  List<Category> data;

  Data({
    required this.meta,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    meta: Meta.fromJson(json["meta"]),
    data: List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Category {
  String id;
  String name;
  String? icon;
  String description;
  List<Subcategory> subcategories;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String? img;

  Category({
    required this.id,
    required this.name,
    this.icon,
    required this.description,
    required this.subcategories,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.img,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    name: json["name"],
    icon: json["icon"],
    description: json["description"],
    subcategories: List<Subcategory>.from(json["subcategories"].map((x) => Subcategory.fromJson(x))),
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "icon": icon,
    "description": description,
    "subcategories": List<dynamic>.from(subcategories.map((x) => x.toJson())),
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "img": img,
  };
}

class Subcategory {
  String id;
  String name;
  String description;
  bool status;
  String category;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Subcategory({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    status: json["status"],
    category: json["category"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "description": description,
    "status": status,
    "category": category,
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
