class QueriesShowModel {
  bool? success;
  Data? data;

  QueriesShowModel({this.success, this.data});

  QueriesShowModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  CustomerQuery? customerQuery;
  List<Reply>? replies;

  Data({this.customerQuery, this.replies});

  Data.fromJson(Map<String, dynamic> json) {
    customerQuery = json['customerQuery'] != null ? CustomerQuery.fromJson(json['customerQuery']) : null;
    if (json['replies'] != null) {
      replies = <Reply>[];
      json['replies'].forEach((v) {
        replies!.add(Reply.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customerQuery != null) {
      data['customerQuery'] = customerQuery!.toJson();
    }
    if (replies != null) {
      data['replies'] = replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerQuery {
  int? id;
  String? userId;
  String? companyId;
  String? customerQuery;
  String? description;
  String? isSeen;
  String? createdAt;
  String? updatedAt;
  List<Reply>? replies;

  CustomerQuery({this.id, this.userId, this.companyId, this.customerQuery, this.description, this.isSeen, this.createdAt, this.updatedAt, this.replies});

  CustomerQuery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    companyId = json['company_id'];
    customerQuery = json['customer_query'];
    description = json['description'];
    isSeen = json['is_seen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['replies'] != null) {
      replies = <Reply>[];
      json['replies'].forEach((v) {
        replies!.add(Reply.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['company_id'] = companyId;
    data['customer_query'] = customerQuery;
    data['description'] = description;
    data['is_seen'] = isSeen;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (replies != null) {
      data['replies'] = replies!.map((v) => v.toJson()).toList();
    }
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
