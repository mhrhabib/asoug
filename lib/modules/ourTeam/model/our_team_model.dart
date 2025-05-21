class OurTeamModel {
  bool? success;
  List<Team>? data;

  OurTeamModel({this.success, this.data});

  OurTeamModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Team>[];
      json['data'].forEach((v) {
        data!.add(Team.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Team {
  int? id;
  String? userId;
  String? title;
  String? mediaUploadId;
  String? metaTitle;
  String? metaKeywords;
  String? metaDescription;
  String? status;
  String? shortDescription;
  String? keywords;
  String? content;
  String? publishedAt;
  String? isFeatured;
  String? isActive;
  String? slug;
  String? imageUrl;
  String? userName;
  User? user;

  Team(
      {this.id,
      this.userId,
      this.title,
      this.mediaUploadId,
      this.metaTitle,
      this.metaKeywords,
      this.metaDescription,
      this.status,
      this.shortDescription,
      this.keywords,
      this.content,
      this.publishedAt,
      this.isFeatured,
      this.isActive,
      this.slug,
      this.imageUrl,
      this.userName,
      this.user});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    mediaUploadId = json['media_upload_id'];
    metaTitle = json['meta_title'];
    metaKeywords = json['meta_keywords'];
    metaDescription = json['meta_description'];
    status = json['status'];
    shortDescription = json['short_description'];
    keywords = json['keywords'];
    content = json['content'];
    publishedAt = json['published_at'];
    isFeatured = json['is_featured'];
    isActive = json['is_active'];
    slug = json['slug'];
    imageUrl = json['image_url'];
    userName = json['user_name'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['title'] = title;
    data['media_upload_id'] = mediaUploadId;
    data['meta_title'] = metaTitle;
    data['meta_keywords'] = metaKeywords;
    data['meta_description'] = metaDescription;
    data['status'] = status;
    data['short_description'] = shortDescription;
    data['keywords'] = keywords;
    data['content'] = content;
    data['published_at'] = publishedAt;
    data['is_featured'] = isFeatured;
    data['is_active'] = isActive;
    data['slug'] = slug;
    data['image_url'] = imageUrl;
    data['user_name'] = userName;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  dynamic createdAt;
  String? updatedAt;
  dynamic phone;
  dynamic avatar;
  dynamic otp;
  dynamic businessType;
  dynamic taxNumber;
  dynamic commercialRegistrationNumber;
  String? isActive;
  String? avatarUrl;

  User({this.id, this.name, this.email, this.emailVerifiedAt, this.createdAt, this.updatedAt, this.phone, this.avatar, this.otp, this.businessType, this.taxNumber, this.commercialRegistrationNumber, this.isActive, this.avatarUrl});

  User.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
