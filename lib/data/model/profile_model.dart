
class ProfileModel {
  int? statusCode;
  bool? success;
  String? message;
  ProfileData? data;
  ProfileModel({this.statusCode, this.success, this.message, this.data});
  ProfileModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }
}

class ProfileData {
  String? sId;
  String? email;
  bool? isDonor;
  String? bloodGroup;
  String? name;
  String? phone;
  String? upazila;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? lastDonateDate;
  String? image;

  ProfileData(
      {this.sId,
        this.email,
        this.isDonor,
        this.bloodGroup,
        this.name,
        this.phone,
        this.upazila,
        this.createdAt,
        this.updatedAt,
        this.lastDonateDate,
        this.image,
        this.iV});

  ProfileData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isDonor = json['isDonor'];
    bloodGroup = json['bloodGroup'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    upazila = json['upazila'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    lastDonateDate = json['lastDonateDate'];
    image = json['image'];
    iV = json['__v'];
  }
}
