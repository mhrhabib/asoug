class SupportsModel {
  bool? success;
  List<Support>? data;

  SupportsModel({this.success, this.data});

  SupportsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Support>[];
      json['data'].forEach((v) {
        data!.add(Support.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Support {
  int? id;
  String? userId;
  String? issue;
  String? ticket;
  String? description;
  dynamic attachment;
  String? isSeen;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? attachmentUrl;
  List<Reply>? replies;
  User? user;

  Support({this.id, this.userId, this.issue, this.ticket, this.description, this.attachment, this.isSeen, this.status, this.createdAt, this.updatedAt, this.attachmentUrl, this.replies, this.user});

  Support.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    issue = json['issue'];
    ticket = json['ticket'];
    description = json['description'];
    attachment = json['attachment'];
    isSeen = json['is_seen'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    attachmentUrl = json['attachment_url'];
    if (json['replies'] != null) {
      replies = <Reply>[];
      json['replies'].forEach((v) {
        replies!.add(Reply.fromJson(v));
      });
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['issue'] = issue;
    data['ticket'] = ticket;
    data['description'] = description;
    data['attachment'] = attachment;
    data['is_seen'] = isSeen;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['attachment_url'] = attachmentUrl;
    if (replies != null) {
      data['replies'] = replies!.map((v) => v.toJson()).toList();
    }
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
    final Map<String, dynamic> data = <String, dynamic>{};
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

class Reply {
  final String title;
  final String description;
  final String imageUrl;

  Reply({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  // Factory constructor to create a Reply from JSON
  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  // Method to convert a Reply object to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
