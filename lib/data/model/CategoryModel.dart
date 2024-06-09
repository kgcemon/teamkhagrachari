import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) => List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));

class CategoryModel {
  String id;
  String name;
  String? img;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  CategoryModel({
    required this.id,
    required this.name,
    this.img,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["_id"],
    name: json["name"],
    img: json["img"],
    description: json["description"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );
}
