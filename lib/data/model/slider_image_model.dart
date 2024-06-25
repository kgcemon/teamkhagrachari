import 'dart:convert';

SliderImageModel sliderImageModelFromJson(String str) => SliderImageModel.fromJson(json.decode(str));

String sliderImageModelToJson(SliderImageModel data) => json.encode(data.toJson());

class SliderImageModel {
  int statusCode;
  bool success;
  String message;
  List<Datum> data;

  SliderImageModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });

  factory SliderImageModel.fromJson(Map<String, dynamic> json) => SliderImageModel(
    statusCode: json["statusCode"],
    success: json["success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String img;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Datum({
    required this.id,
    required this.img,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    img: json["img"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "img": img,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
