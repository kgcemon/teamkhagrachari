import 'dart:convert';

List<SebaDetailsModel> sebaDetailsModelFromJson(String str) => List<SebaDetailsModel>.from(json.decode(str).map((x) => SebaDetailsModel.fromJson(x)));

String sebaDetailsModelToJson(List<SebaDetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SebaDetailsModel {
  String id;
  String name;
  String description;
  String phone;
  ServicesCatagory servicesCatagory;
  User user;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  SebaDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.phone,
    required this.servicesCatagory,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SebaDetailsModel.fromJson(Map<String, dynamic> json) => SebaDetailsModel(
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    phone: json["phone"],
    servicesCatagory: ServicesCatagory.fromJson(json["servicesCatagory"]),
    user: User.fromJson(json["user"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "description": description,
    "phone": phone,
    "servicesCatagory": servicesCatagory.toJson(),
    "user": user.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class ServicesCatagory {
  String id;
  String name;
  String? img;
  Description description;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  ServicesCatagory({
    required this.id,
    required this.name,
    this.img,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ServicesCatagory.fromJson(Map<String, dynamic> json) => ServicesCatagory(
    id: json["_id"],
    name: json["name"],
    img: json["img"],
    description: descriptionValues.map[json["description"]]!,
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "img": img,
    "description": descriptionValues.reverse[description],
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

enum Description {
  ASAD,
  EMON,
  THIS_IS_DESCRIPTION
}

final descriptionValues = EnumValues({
  "asad": Description.ASAD,
  "emon": Description.EMON,
  "this is description": Description.THIS_IS_DESCRIPTION
});

class User {
  Id id;
  Email email;
  Name name;
  String phone;
  Upazila upazila;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.upazila,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: idValues.map[json["_id"]]!,
    email: emailValues.map[json["email"]]!,
    name: nameValues.map[json["name"]]!,
    phone: json["phone"],
    upazila: upazilaValues.map[json["upazila"]]!,
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": idValues.reverse[id],
    "email": emailValues.reverse[email],
    "name": nameValues.reverse[name],
    "phone": phone,
    "upazila": upazilaValues.reverse[upazila],
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

enum Email {
  USER4_GMAIL_COM,
  USER5_GMAIL_COM
}

final emailValues = EnumValues({
  "user4@gmail.com": Email.USER4_GMAIL_COM,
  "user5@gmail.com": Email.USER5_GMAIL_COM
});

enum Id {
  THE_664239_B5_CD1_F9_D929_DA67506,
  THE_664240857_B830_FF658_E725_F6
}

final idValues = EnumValues({
  "664239b5cd1f9d929da67506": Id.THE_664239_B5_CD1_F9_D929_DA67506,
  "664240857b830ff658e725f6": Id.THE_664240857_B830_FF658_E725_F6
});

enum Name {
  USER1
}

final nameValues = EnumValues({
  "user1": Name.USER1
});

enum Upazila {
  KGC
}

final upazilaValues = EnumValues({
  "kgc": Upazila.KGC
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
