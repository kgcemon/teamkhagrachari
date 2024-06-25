import 'dart:async';

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
  String? name;
  String? phone;
  String? upazila;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? lastDonateDate;

  ProfileData(
      {this.sId,
        this.email,
        this.name,
        this.phone,
        this.upazila,
        this.createdAt,
        this.updatedAt,
        this.lastDonateDate,
        this.iV});

  ProfileData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    upazila = json['upazila'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    lastDonateDate = json['lastDonateDate'];
    iV = json['__v'];
  }
}
