class QueriesModel {
  List<Query>? data;
  bool? success;

  QueriesModel({this.data, this.success});

  QueriesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Query>[];
      json['data'].forEach((v) {
        data!.add(Query.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    return data;
  }
}

class Query {
  int? id;
  String? userId;
  String? companyId;
  String? customerQuery;
  String? description;
  String? isSeen;
  String? createdAt;
  String? updatedAt;

  Query({this.id, this.userId, this.companyId, this.customerQuery, this.description, this.isSeen, this.createdAt, this.updatedAt});

  Query.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    companyId = json['company_id'];
    customerQuery = json['customer_query'];
    description = json['description'];
    isSeen = json['is_seen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}
