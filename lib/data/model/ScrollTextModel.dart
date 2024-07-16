class ScrollTextModel {
  int? statusCode;
  bool? success;
  String? message;
  List<Data>? data;

  ScrollTextModel({this.statusCode, this.success, this.message, this.data});

  ScrollTextModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? sId;
  String? text;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
        this.text,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    text = json['text'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
