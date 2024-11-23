class BloodModel {
  String? sId;
  String? email;
  String? name;
  String? phone;
  String? bloodGroup;
  String? lastDonateDate;
  String? upazila;
  bool? isDonor;
  String? createdAt;
  String? updatedAt;
  String? image;
  int? iV;

  BloodModel(
      {this.sId,
        this.email,
        this.name,
        this.phone,
        this.bloodGroup,
        this.lastDonateDate,
        this.upazila,
        this.isDonor,
        this.createdAt,
        this.updatedAt,
        this.image,
        this.iV});

  BloodModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    bloodGroup = json['bloodGroup'];
    lastDonateDate = json['lastDonateDate'];
    upazila = json['upazila'];
    isDonor = json['isDonor'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    image = json['image'];
    iV = json['__v'];
  }

}
