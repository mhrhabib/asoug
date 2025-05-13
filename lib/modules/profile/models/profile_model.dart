class ProfileModel {
  dynamic id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? phone;
  String? avatar;
  dynamic otp;
  dynamic businessType;
  dynamic taxNumber;
  dynamic commercialRegistrationNumber;
  String? isActive;
  String? avatarUrl;

  ProfileModel({this.id, this.name, this.email, this.emailVerifiedAt, this.createdAt, this.updatedAt, this.phone, this.avatar, this.otp, this.businessType, this.taxNumber, this.commercialRegistrationNumber, this.isActive, this.avatarUrl});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    phone = json['phone'];
    avatar = json['avatar'];
    otp = json['otp'];
    businessType = json['business_type'];
    taxNumber = json['tax_number'];
    commercialRegistrationNumber = json['commercial_registration_number'];
    isActive = json['is_active'];
    avatarUrl = json['avatarUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['phone'] = phone;
    data['avatar'] = avatar;
    data['otp'] = otp;
    data['business_type'] = businessType;
    data['tax_number'] = taxNumber;
    data['commercial_registration_number'] = commercialRegistrationNumber;
    data['is_active'] = isActive;
    data['avatarUrl'] = avatarUrl;
    return data;
  }
}
